//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================
// This is an artillery type used for backwards compatibility with the old
// Red Orchestra artillery system.
//==============================================================================

class DHArtillery_105mm extends DHArtillery;

var int ShellCounter; // no. of shells fired so far in current salvo (renamed from SpawnCounter)
var int SalvoCounter; // no. of salvoes fired so far

var DHArtilleryShell LastSpawnedShell; // reference to the last artillery shell spawned by this arty spawner

// Arty strike properties, taken from team's arty settings in the map's DHLevelInfo
var int BatteryCount;  // no. of shells per salvo
var int SalvoAmount;  // no. of salvoes in this strike
var int SpreadAmount; // randomised spread of each shell (in UU)

var DHGameReplicationInfo GRI;

function int GetBatteryCount(DH_LevelInfo.EBatterySize BatterySize)
{
    switch(BatterySize)
    {
        case BATTERY_Small:
            return 2;
        case BATTERY_Medium:
            return 4;
        case BATTERY_Large: 
            return 8;
    }
}


function Setup()
{
    local DH_LevelInfo      LI;
    local DH_LevelInfo.ArtilleryType    AT;
    local float             StrikeDelay, MaxSalvoDuration;
    


    // Get arty strike properties from our team's settings in the map's DHLevelInfo
    LI = class'DH_LevelInfo'.static.GetInstance(Level);

    if (FireMissionIndex == 0)
    {
        BatteryCount = GetBatteryCount(AT.BatterySize); 
        SalvoAmount = 3;
        SpreadAmount = LI.GetSpreadAmount(TeamIndex);
        StrikeDelay = float(LI.GetStrikeDelay(TeamIndex)) * (0.85 + (FRand() * 0.3));  // +/- 15% randomisation on delay

    }

    //BatterySize = LI.GetBatterySize(TeamIndex) * (FireMissionIndex + 1);
    //log(FireMissionIndex);
    //SalvoAmount = LI.GetSalvoAmount(TeamIndex);
    //SpreadAmount = LI.GetSpreadAmount(TeamIndex);
    // = float(LI.GetStrikeDelay(TeamIndex)) * (0.85 + (FRand() * 0.3));  // +/- 15% randomisation on delay


    // Set timer until arty strike begins
    SetTimer(FMax(StrikeDelay, 1.0), false); // added a minimum to avoid any possibility of setting a null timer

    // Set LifeSpan until this actor destroys itself
    // Added as a fail-safe in case the sequence of timers somehow gets interrupted & we don't ever get to end of arty strike
    // If that happened this actor wouldn't destroy itself & arty strike would remain 'live', stopping the team from calling any more arty
    // This actor's LifeSpan is set to the maximum possible length of the strike, assuming the max random time between shells & salvoes
    MaxSalvoDuration = 1.5 * (BatteryCount - 1);
    LifeSpan = StrikeDelay + (20.0 * (SalvoAmount - 1)) + (SalvoAmount * MaxSalvoDuration) + 1.0;

    super.Setup();

}

// From deprecated ROArtillerySpawner, optimised a little
// And setting a LifeSpan for this actor, as a fail-safe in case the sequence of timers somehow gets interrupted & we don't ever get to end of arty strike
function PostBeginPlay()
{
    local DH_LevelInfo.ArtilleryType    AT;

    super.PostBeginPlay();

    if (Level == none || Level.Game == none)
    {
        Destroy();
        return;
    }

    GRI = DHGameReplicationInfo(Level.Game.GameReplicationInfo);

    if (GRI == none)
    {
        Destroy();
        return;
    }

    BatteryCount = GetBatteryCount(AT.BatterySize);
   
}

// From deprecated ROArtillerySpawner
function Destroyed()
{
    // TODO: this is retarded
    if (ROGameReplicationInfo(Level.Game.GameReplicationInfo) != none)
    {
        ROGameReplicationInfo(Level.Game.GameReplicationInfo).ArtyStrikeLocation[TeamIndex] = vect(0.0, 0.0, 0.0);
    }
    else
    {
        Log("DHArtillerySpawner ERROR: actor destroyed but no GRI so can't clear the ArtyStrikeLocation to end the strike!");
    }
    LastSpawnedShell = none;
    GRI.InvalidateOngoingBarrageMarker(TeamIndex);
}

// Modified from deprecated ROArtillerySpawner to fix log errors causing 1 extra salvo & 1 extra shell per salvo (& re-factored a little to optimise)
// Also spawning shells a fixed distance above strike location as this actor is now located on strike location & we have deprecated OriginalArtyLocation
// And to stop shell being always net relevant to player who called arty as he was made its owner (now use another method to set shell's InstigatorController)
// Benefit if player re-spawns or otherwise moves well away from arty strike, as server can decide whether shells are relevant & should be replicated to him
function Timer()
{
    local DHVolumeTest VT;
    local vector       RandomSpread;
    local bool         bInvalid;

    // Cancel the strike if the arty officer has switched teams or left the server, or if the round is over
    if (Controller(Owner) == none || Controller(Owner).GetTeamNum() != TeamIndex || !(ROTeamGame(Level.Game) != none && ROTeamGame(Level.Game).IsInState('RoundInPlay')))
    {
        bInvalid = true;
    }
    // Check whether the target location has become a NoArtyVolume after the strike was called - if it has then cancel the strike
    else
    {
        VT = Spawn(class'DHVolumeTest', self,, Location); // using Location instead of deprecated OriginalArtyLocation this actor now located on strike location

        if (VT != none)
        {
            if (VT.DHIsInNoArtyVolume(GRI))
            {
                bInvalid = true;

                if (Owner.IsA('PlayerController'))
                {
                    PlayerController(Owner).ReceiveLocalizedMessage(class'ROArtilleryMsg', 5); // not a valid artillery target
                }
            }

            VT.Destroy();
        }
    }

    // If not a valid strike then destroy this actor & any recent shell it spawned
    if (bInvalid)
    {
        if (LastSpawnedShell != none && !LastSpawnedShell.bDeleteMe)
        {
            LastSpawnedShell.Destroy();
        }

        Destroy();

        return;
    }

    // Make sure this salvo hasn't finished & then spawn an arty shell, with randomised spread based on the map's arty settings for the team
    if (ShellCounter < BatteryCount)
    {
        RandomSpread.X += Rand((2 * SpreadAmount) + 1) - SpreadAmount; // gives +/- zero to SpreadAmount
        RandomSpread.Y += Rand((2 * SpreadAmount) + 1) - SpreadAmount;

        // Altered to spawn shell a standard approx 50m above strike location & to use a different method of setting shell's InstigatorController
        LastSpawnedShell = Spawn(class'DHArtilleryShell',,, Location + vect(0.0, 0.0, 3000.0) + RandomSpread, rotator(PhysicsVolume.Gravity));

        if (LastSpawnedShell != none)
        {
            LastSpawnedShell.SetInstigatorController(Controller(Owner));
            ShellCounter++;
        }

        // If this salvo still has remaining shells to land, set a new, fairly short timer to spawn the next shell & exit
        if (ShellCounter < BatteryCount)
        {
            SetTimer(0.05 + (FRand() * 1.45), false); // randomised 0.05 to 1.5 seconds between shells (0.05 minimum to avoid any possibility of setting a null timer)

            return;
        }
        // Otherwise this salvo has ended so increment the salvo counter
        else
        {
            SalvoCounter++;
        }
    }

    // If there's still at least one more salvo to come, set a new, longer timer to start the next salvo
    if (SalvoCounter < SalvoAmount)
    {
        ShellCounter = 0; // reset shell counter for next salvo
        SetTimer(10.0 + (FRand() * 10.0), false); // randomised 10 to 20 seconds between salvoes
    }
    // Otherwise destroy this actor as the arty strike has finished
    else
    {
        Destroy();
    }
}

static function int GetLimitOverride(int TeamIndex, LevelInfo Level)
{
    local DH_LevelInfo LI;

    LI = class'DH_LevelInfo'.static.GetInstance(Level);

    if (LI == none)
    {
        return -1;
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return LI.Axis.ArtilleryStrikeLimit;
        case ALLIES_TEAM_INDEX:
            return LI.Allies.ArtilleryStrikeLimit;
    }

    return -1;
}

static function int GetConfirmIntervalSecondsOverride(int TeamIndex, LevelInfo Level)
{
    local DH_LevelInfo LI;

    LI = class'DH_LevelInfo'.static.GetInstance(Level);

    if (LI == none)
    {
        return -1;
    }

    // HACK: The 2x multiplier is a stopgap solution to stop artillery from
    // being so damned frequent.
    return LI.GetStrikeInterval(TeamIndex) * 2.0;
}





defaultproperties
{
   MenuName="Medium concentration 105mm Artillery"
   bAlwaysRelevant=true

    FireMissions(0)=(MenuName="Fire-mission TRP")
    FireMissions(1)=(MenuName="Fire-mission Barrage")
    FireMissions(2)=(MenuName="Fire-mission Surpressive")
}