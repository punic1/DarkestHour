//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHArtillery_Rocket_katusha extends DHArtillery;

var int RocketCounter; //no. of rockets fired so far in salvo
var int SalvoCounter; //no. of salvoes fired so far

var DHArtilleryShell LastSpawnedShell; // reference to the last artillery shell spawned by this arty spawner

//Rocket strike properties
var int BatterySize; //no. of launchers in battery
var int SalvoAmount; //no. of salvoes in strike
var int SpreadAmount; // randomised spread of each shell (in UU)
var int RocketAmount; //no. of rockets in salvo

var DHGameReplicationInfo GetMainSpawnPoint;



function PostBeginPlay()
{
     local vector       RandomSpread;
     
    
    
    SetTimer(1.0 , True);

    

    RandomSpread.X += Rand((2 * SpreadAmount) + 1) - SpreadAmount; // gives +/- zero to SpreadAmount
    RandomSpread.Y += Rand((2 * SpreadAmount) + 1) - SpreadAmount;


    // Set the team index based on the team of the authoring player.
    Requester = PlayerController(Owner);

    if (Requester != none)
    {
        SetTeamIndex(Requester.GetTeamNum());
    }

    LastSpawnedShell = Spawn(class'DHArtilleryShell',,, Location + vect(0.0, 0.0, 3000.0) + RandomSpread, rotator(PhysicsVolume.Gravity));


}

function Timer()
{
    Log("is it working?????????");


    if (RocketAmount <= 0) 
    {
        Destroy();
    }
    
}

defaultproperties
{
    MenuName="Heavy-Saturation Rocket Artillery"
    bAlwaysRelevant=true

    MenuIcon=Texture'DH_InterfaceArt2_tex.Icons.Artillery'
}