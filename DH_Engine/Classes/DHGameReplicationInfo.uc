//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2017
//==============================================================================

class DHGameReplicationInfo extends ROGameReplicationInfo;

const RADIOS_MAX = 10;
const ROLES_MAX = 16;
const MORTAR_TARGETS_MAX = 2;
const VEHICLE_POOLS_MAX = 32;
const SPAWN_POINTS_MAX = 63;
const OBJECTIVES_MAX = 32;
const CONSTRUCTION_CLASSES_MAX = 32;
const VOICEID_MAX = 255;
const SUPPLY_POINTS_MAX = 15;
const MAP_MARKERS_MAX = 20;
const MAP_MARKERS_CLASSES_MAX = 16;
const ARTILLERY_TYPES_MAX = 8;
const ARTILLERY_MAX = 8;

enum VehicleReservationError
{
    ERROR_None,
    ERROR_Fatal,
    ERROR_InvalidCredentials,
    ERROR_TeamMaxActive,
    ERROR_PoolOutOfSpawns,
    ERROR_PoolInactive,
    ERROR_PoolMaxActive,
    ERROR_NoReservations,
    ERROR_NoSquad
};

struct ArtilleryTarget
{
    var bool            bIsActive;
    var DHPlayer        Controller;
    var byte            TeamIndex;
    var vector          Location;
    var vector          HitLocation;
    var float           Time;
    var bool            bIsSmoke;   // TODO: convert to enum
};

struct SpawnVehicle
{
    var int             SpawnPointIndex;
    var int             VehiclePoolIndex;
    var Vehicle         Vehicle;
};

struct SupplyPoint
{
    var byte bIsActive;
    var byte TeamIndex;
    var DHConstructionSupplyAttachment Actor;
    var int Quantized2DPose;
    var class<DHConstructionSupplyAttachment> ActorClass;
};

// The request error type.
enum EArtilleryTypeError
{
    ERROR_None,
    ERROR_Fatal,
    ERROR_Unavailable,
    ERROR_Exhausted,
    ERROR_Unqualified,
    ERROR_Cooldown,
    ERROR_Ongoing,
    ERROR_SquadTooSmall
};

var class<DHGameType>   GameType;

var SupplyPoint         SupplyPoints[SUPPLY_POINTS_MAX];

var DHRadio             Radios[RADIOS_MAX];

var int                 AlliedNationID;
var int                 AlliesVictoryMusicIndex;
var int                 AxisVictoryMusicIndex;

var int                 RoundEndTime;       // Length of a round in seconds (this can be modified at real time unlike RoundDuration, which it replaces)
var int                 RoundOverTime;      // The time stamp at which the round is over
var int                 SpawningEnableTime; // When spawning for the round should be enabled (default: 0)

var int                 DHRoundLimit;       // Added this so that a changing round limit can be replicated to clients.
var int                 DHRoundDuration;    // Added this so that a more flexible changing round duration can be replicated to clients (e.g change to unlimited)

var DHRoleInfo          DHAxisRoles[ROLES_MAX];
var DHRoleInfo          DHAlliesRoles[ROLES_MAX];

var DHArtillery         DHArtillery[ARTILLERY_MAX];

var byte                DHAlliesRoleLimit[ROLES_MAX];
var byte                DHAlliesRoleBotCount[ROLES_MAX];
var byte                DHAlliesRoleCount[ROLES_MAX];
var byte                DHAxisRoleLimit[ROLES_MAX];
var byte                DHAxisRoleBotCount[ROLES_MAX];
var byte                DHAxisRoleCount[ROLES_MAX];

// The maximum distance an artillery strike can be away from a marked target for
// a hit indicator to show on the map
var float               ArtilleryTargetDistanceThreshold;

var ArtilleryTarget     AlliedArtilleryTargets[MORTAR_TARGETS_MAX];
var ArtilleryTarget     GermanArtilleryTargets[MORTAR_TARGETS_MAX];

var int                 SpawnsRemaining[2];
var float               AttritionRate[2];
var float               CurrentAlliedToAxisRatio;

// TODO: vehicle classes should have been made available in static data for client and server to read
var class<ROVehicle>    VehiclePoolVehicleClasses[VEHICLE_POOLS_MAX];
var byte                VehiclePoolIsActives[VEHICLE_POOLS_MAX];
var float               VehiclePoolNextAvailableTimes[VEHICLE_POOLS_MAX];
var byte                VehiclePoolActiveCounts[VEHICLE_POOLS_MAX];
var byte                VehiclePoolMaxActives[VEHICLE_POOLS_MAX];
var byte                VehiclePoolMaxSpawns[VEHICLE_POOLS_MAX];
var byte                VehiclePoolSpawnCounts[VEHICLE_POOLS_MAX];
var byte                VehiclePoolIsSpawnVehicles[VEHICLE_POOLS_MAX];
var byte                VehiclePoolReservationCount[VEHICLE_POOLS_MAX];
var int                 VehiclePoolIgnoreMaxTeamVehiclesFlags;

var int                 MaxTeamVehicles[2];

var DHSpawnPointBase    SpawnPoints[SPAWN_POINTS_MAX];

var DHObjective         DHObjectives[OBJECTIVES_MAX];

var bool                bIsInSetupPhase;
var bool                bRoundIsOver;

var localized string    ForceScaleText;
var localized string    ReinforcementsInfiniteText;

var private array<string>   ConstructionClassNames;
var class<DHConstruction>   ConstructionClasses[CONSTRUCTION_CLASSES_MAX];
var DHConstructionManager   ConstructionManager;

var bool                bAreConstructionsEnabled;
var bool                bAllowAllChat;

var byte                ServerHealth;

// Map markers
struct MapMarker
{
    var class<DHMapMarker> MapMarkerClass;
    var byte LocationX;     // Quantized representation of 0.0..1.0
    var byte LocationY;
    var byte SquadIndex;    // The squad index that owns the marker, or -1 if team-wide
    var int ExpiryTime;     // The expiry time, relative to ElapsedTime in GRI
};

// This handles the mutable artillery type info (classes, team indices can be fetched from static data in DH_LevelInfo).
// TODO: reset this somewhere on round begin
struct ArtilleryTypeInfo
{
    var bool                bIsAvailable;               // Whether or not this type of artillery is available (can be made available and unavailable during a round).
    var int                 UsedCount;                  // The amount of times this artillery type has been confirmed.
    var int                 Limit;                      // The amount of these types of artillery strikes that are available.
    var int                 NextConfirmElapsedTime;     // The next time, relative to ElapsedTime, that a request can confirmed for this artillery type.
    var DHArtillery         ArtilleryActor;             // Artillery actor.
};
var ArtilleryTypeInfo                   ArtilleryTypeInfos[ARTILLERY_TYPES_MAX];

var private array<string>               MapMarkerClassNames;
var class<DHMapMarker>                  MapMarkerClasses[MAP_MARKERS_CLASSES_MAX];
var MapMarker                           AxisMapMarkers[MAP_MARKERS_MAX];
var MapMarker                           AlliesMapMarkers[MAP_MARKERS_MAX];

replication
{
    // Variables the server will replicate to all clients
    reliable if (bNetDirty && Role == ROLE_Authority)
        RoundEndTime,
        SpawnsRemaining,
        DHAxisRoles,
        DHAlliesRoles,
        DHAlliesRoleLimit,
        DHAlliesRoleCount,
        DHAxisRoleLimit,
        DHAxisRoleCount,
        DHAlliesRoleBotCount,
        DHAxisRoleBotCount,
        Radios,
        AlliedArtilleryTargets,
        GermanArtilleryTargets,
        VehiclePoolVehicleClasses,
        VehiclePoolIsActives,
        VehiclePoolNextAvailableTimes,
        VehiclePoolActiveCounts,
        VehiclePoolMaxActives,
        VehiclePoolMaxSpawns,
        VehiclePoolSpawnCounts,
        VehiclePoolIsSpawnVehicles,
        VehiclePoolReservationCount,
        VehiclePoolIgnoreMaxTeamVehiclesFlags,
        MaxTeamVehicles,
        DHObjectives,
        AttritionRate,
        GameType,
        CurrentAlliedToAxisRatio,
        SpawnPoints,
        SpawningEnableTime,
        bIsInSetupPhase,
        bRoundIsOver,
        bAreConstructionsEnabled,
        SupplyPoints,
        AxisMapMarkers,
        AlliesMapMarkers,
        bAllowAllChat,
        RoundOverTime,
        DHRoundLimit,
        DHRoundDuration,
        ServerHealth,
        ArtilleryTypeInfos,
        DHArtillery;

    reliable if (bNetInitial && Role == ROLE_Authority)
        AlliedNationID, AlliesVictoryMusicIndex, AxisVictoryMusicIndex,
        ConstructionClasses, MapMarkerClasses;
}

// Modified to build SpawnPoints array
// Also to nullify all water splash effects in WaterVolumes & FluidSurfaceInfos, as they clash with splash effects in projectile classes that are more specific to the projectile
// Another problem is a big splash effect was being played for every ejected bullet shell case that hit water, looking totally wrong for such a small, relatively slow object
simulated function PostBeginPlay()
{
    local WaterVolume       WV;
    local FluidSurfaceInfo  FSI;
    local int               i, j;
    local DH_LevelInfo      LI;
    local class<DHMapMarker> MapMarkerClass;

    super.PostBeginPlay();

    foreach AllActors(class'WaterVolume', WV)
    {
        WV.PawnEntryActor = none;
        WV.PawnEntryActorName = "";
        WV.EntryActor = none;
        WV.EntryActorName = "";
        WV.EntrySound = none;
        WV.EntrySoundName = "";
        WV.ExitActor = none;
        WV.ExitSound = none;
        WV.ExitSoundName = "";
    }

    foreach AllActors(class'FluidSurfaceInfo', FSI)
    {
        FSI.TouchEffect = none;
    }

    if (Role == ROLE_Authority)
    {
        for (i = 0; i < ConstructionClassNames.Length; ++i)
        {
            AddConstructionClass(class<DHConstruction>(DynamicLoadObject(ConstructionClassNames[i], class'class')));
        }

        LI = class'DH_LevelInfo'.static.GetInstance(Level);

        if (LI != none)
        {
            bAreConstructionsEnabled = LI.bAreConstructionsEnabled;
        }

        // Add usable map markers to the class list to be replicated!
        j = 0;

        for (i = 0; i < MapMarkerClassNames.Length; ++i)
        {
            MapMarkerClass = class<DHMapMarker>(DynamicLoadObject(MapMarkerClassNames[i], class'class'));

            if (MapMarkerClass != none && MapMarkerClass.static.CanBeUsed(self))
            {
                MapMarkerClasses[j++] = MapMarkerClass;
            }
        }
    }
}

function int AddConstructionClass(class<DHConstruction> ConstructionClass)
{
    local int i;

    if (ConstructionClass != none)
    {
        for (i = 0; i < arraycount(ConstructionClasses); ++i)
        {
            if (ConstructionClasses[i] == none)
            {
                ConstructionClasses[i] = ConstructionClass;
                return i;
            }
        }
    }

    return -1;
}

// Modified for net client to check whether local local player has his weapons locked & it's now time to unlock them
simulated event Timer()
{
    super.Timer();

    if (Role < ROLE_Authority && DHPlayer(Level.GetLocalPlayerController()) != none)
    {
        DHPlayer(Level.GetLocalPlayerController()).CheckUnlockWeapons();
    }
}

//==============================================================================
// Supply Points
//==============================================================================

function int AddSupplyPoint(DHConstructionSupplyAttachment CSA)
{
    local int i;
    local float X, Y;

    if (CSA != none)
    {
        for (i = 0; i < arraycount(SupplyPoints); ++i)
        {
            if (SupplyPoints[i].Actor == none)
            {
                SupplyPoints[i].bIsActive = 1;
                SupplyPoints[i].Actor = CSA;
                SupplyPoints[i].TeamIndex = CSA.GetTeamIndex();
                SupplyPoints[i].ActorClass = CSA.Class;
                GetMapCoords(CSA.Location, X, Y);
                SupplyPoints[i].Quantized2DPose = class'UQuantize'.static.QuantizeClamped2DPose(X, Y, CSA.Rotation.Yaw);
                return i;
            }
        }
    }

    return -1;
}

function RemoveSupplyPoint(DHConstructionSupplyAttachment CSA)
{
    local int i;

    if (CSA != none)
    {
        for (i = 0; i < arraycount(SupplyPoints); ++i)
        {
            if (SupplyPoints[i].Actor == CSA)
            {
                SupplyPoints[i].bIsActive = 0;
                SupplyPoints[i].Actor = none;
                break;
            }
        }
    }
}

//==============================================================================
// Spawn Points
//==============================================================================

simulated function int AddSpawnPoint(DHSpawnPointBase SP)
{
    local int i;

    if (SP == none)
    {
        return -1;
    }

    for (i = 0; i < arraycount(SpawnPoints); ++i)
    {
        if (SP == SpawnPoints[i])
        {
            return -1;
        }
    }

    for (i = 0; i < arraycount(SpawnPoints); ++i)
    {
        if (SpawnPoints[i] == none)
        {
            SpawnPoints[i] = SP;
            return i;
        }
    }

    return -1;
}

simulated function DHSpawnPointBase GetSpawnPoint(int SpawnPointIndex)
{
    if (SpawnPointIndex < 0 || SpawnPointIndex >= arraycount(SpawnPoints))
    {
        return none;
    }

    return SpawnPoints[SpawnPointIndex];
}

simulated function bool IsRallyPointIndexValid(DHPlayer PC, byte RallyPointIndex, int TeamIndex)
{
    local DHSpawnPoint_SquadRallyPoint RP;
    local DHPlayerReplicationInfo PRI;

    if (PC == none || PC.SquadReplicationInfo == none)
    {
        return false;
    }

    PRI = DHPlayerReplicationInfo(PC.PlayerReplicationInfo);

    RP = PC.SquadReplicationInfo.RallyPoints[RallyPointIndex];

    if (RP == none || PRI == none || PRI.Team.TeamIndex != RP.GetTeamIndex() || PRI.SquadIndex != RP.SquadIndex)
    {
        return false;
    }

    return true;
}

simulated function bool CanSpawnWithParameters(int SpawnPointIndex, int TeamIndex, int RoleIndex, int SquadIndex, int VehiclePoolIndex, optional bool bSkipTimeCheck)
{
    local DHSpawnPointBase SP;
    local class<DHVehicle> VehicleClass;

    if (VehiclePoolIndex != -1)
    {
        VehicleClass = class<DHVehicle>(GetVehiclePoolVehicleClass(VehiclePoolIndex));

        if (VehicleClass == none ||
            VehicleClass.default.bMustBeInSquadToSpawn && SquadIndex == -1 ||
            !CanSpawnVehicle(VehiclePoolIndex, bSkipTimeCheck))
        {
            return false;
        }
    }

    SP = GetSpawnPoint(SpawnPointIndex);

    return SP != none && SP.CanSpawnWithParameters(self, TeamIndex, RoleIndex, SquadIndex, VehiclePoolIndex, bSkipTimeCheck);
}

simulated function bool CanSpawnVehicle(int VehiclePoolIndex, optional bool bSkipTimeCheck)
{
    local class<ROVehicle> VC;

    if (VehiclePoolIndex < 0 || VehiclePoolIndex >= VEHICLE_POOLS_MAX)
    {
        return false;
    }

    VC = VehiclePoolVehicleClasses[VehiclePoolIndex];

    if (!IgnoresMaxTeamVehiclesFlags(VehiclePoolIndex) && MaxTeamVehicles[VC.default.VehicleTeam] <= 0)
    {
        return false;
    }

    if (!IsVehiclePoolActive(VehiclePoolIndex))
    {
        return false;
    }

    if (!bSkipTimeCheck && ElapsedTime < VehiclePoolNextAvailableTimes[VehiclePoolIndex])
    {
        return false;
    }

    if (VehiclePoolSpawnCounts[VehiclePoolIndex] >= VehiclePoolMaxSpawns[VehiclePoolIndex])
    {
        return false;
    }

    if (VehiclePoolActiveCounts[VehiclePoolIndex] >= VehiclePoolMaxActives[VehiclePoolIndex])
    {
        return false;
    }

    return true;
}

//------------------------------------------------------------------------------
// Vehicle Pool Functions
//------------------------------------------------------------------------------

function SetVehiclePoolIsActive(byte VehiclePoolIndex, bool bIsActive)
{
    local Controller C;
    local DHPlayer PC;

    if (bIsActive)
    {
        VehiclePoolIsActives[VehiclePoolIndex] = 1;
    }
    else
    {
        VehiclePoolIsActives[VehiclePoolIndex] = 0;

        for (C = Level.ControllerList; C != none; C = C.NextController)
        {
            PC = DHPlayer(C);

            if (PC != none && PC.VehiclePoolIndex == VehiclePoolIndex)
            {
                PC.VehiclePoolIndex = -1;
                PC.bSpawnPointInvalidated = true;
            }
        }
    }
}

simulated function bool IsVehiclePoolInfinite(byte VehiclePoolIndex)
{
    return VehiclePoolMaxSpawns[VehiclePoolIndex] == 255;
}

simulated function bool IsVehiclePoolActive(byte VehiclePoolIndex)
{
    return VehiclePoolIsActives[VehiclePoolIndex] != 0;
}

simulated function byte GetVehiclePoolSpawnsRemaining(byte VehiclePoolIndex)
{
    if (IsVehiclePoolInfinite(VehiclePoolIndex))
    {
        return 255;
    }

    return VehiclePoolMaxSpawns[VehiclePoolIndex] - VehiclePoolSpawnCounts[VehiclePoolIndex];
}

simulated function class<Vehicle> GetVehiclePoolVehicleClass(int VehiclePoolIndex)
{
    if (VehiclePoolIndex == -1 || VehiclePoolIndex >= arraycount(VehiclePoolVehicleClasses))
    {
        return none;
    }

    return VehiclePoolVehicleClasses[VehiclePoolIndex];
}

simulated function byte GetVehiclePoolAvailableReservationCount(int VehiclePoolIndex)
{
    local int Active, MaxActive, ReservationCount, VehiclePoolSpawnsRemaning;

    Active = VehiclePoolActiveCounts[VehiclePoolIndex];
    MaxActive = VehiclePoolMaxActives[VehiclePoolIndex];
    ReservationCount = VehiclePoolReservationCount[VehiclePoolIndex];
    VehiclePoolSpawnsRemaning = GetVehiclePoolSpawnsRemaining(VehiclePoolIndex);

    return Min(VehiclePoolSpawnsRemaning, (MaxActive - Active) - ReservationCount);
}

function bool ReserveVehicle(DHPlayer PC, int VehiclePoolIndex)
{
    if (PC == none || VehiclePoolIndex != -1 && GetVehicleReservationError(PC, DHRoleInfo(PC.GetRoleInfo()), PC.GetTeamNum(), VehiclePoolIndex) != ERROR_None)
    {
        return false;
    }

    PC.VehiclePoolIndex = VehiclePoolIndex;

    if (VehiclePoolIndex != -1)
    {
        ++VehiclePoolReservationCount[VehiclePoolIndex];
    }

    return true;
}

function UnreserveVehicle(DHPlayer PC)
{
    if (PC.VehiclePoolIndex != -1)
    {
        --VehiclePoolReservationCount[PC.VehiclePoolIndex];
    }

    PC.VehiclePoolIndex = -1;
}

simulated function bool IgnoresMaxTeamVehiclesFlags(int VehiclePoolIndex)
{
    if (VehiclePoolIndex >= 0)
    {
        return (VehiclePoolIgnoreMaxTeamVehiclesFlags & (1 << VehiclePoolIndex)) != 0;
    }

    return false;
}

//------------------------------------------------------------------------------
// Roles
//------------------------------------------------------------------------------

simulated function DHRoleInfo GetRole(int TeamIndex, int RoleIndex)
{
    if (RoleIndex < 0 || RoleIndex >= arraycount(DHAxisRoles))
    {
        return none;
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            return DHAxisRoles[RoleIndex];
        case ALLIES_TEAM_INDEX:
            return DHAlliesRoles[RoleIndex];
    }

    return none;
}

simulated function int GetRoleIndexAndTeam(RORoleInfo RI, optional out byte Team)
{
    local int i;

    for (i = 0; i < arraycount(DHAxisRoles); ++i)
    {
        if (RI == DHAxisRoles[i])
        {
            Team = AXIS_TEAM_INDEX;

            return i;
        }
    }

    for (i = 0; i < arraycount(DHAlliesRoles); ++i)
    {
        if (RI == DHAlliesRoles[i])
        {
            Team = ALLIES_TEAM_INDEX;

            return i;
        }
    }

    Team = NEUTRAL_TEAM_INDEX;

    return -1;
}

simulated function GetRoleCounts(RORoleInfo RI, out int Count, out int BotCount, out int Limit)
{
    local int Index;
    local byte Team;

    Index = GetRoleIndexAndTeam(RI, Team);

    if (Index == -1)
    {
        return;
    }

    switch (Team)
    {
        case AXIS_TEAM_INDEX:
            Limit = DHAxisRoleLimit[Index];
            Count = DHAxisRoleCount[Index];
            BotCount = DHAxisRoleBotCount[Index];
            break;
        case ALLIES_TEAM_INDEX:
            Limit = DHAlliesRoleLimit[Index];
            Count = DHAlliesRoleCount[Index];
            BotCount = DHAlliesRoleBotCount[Index];
            break;
    }
}

//------------------------------------------------------------------------------
// Artillery Functions
//------------------------------------------------------------------------------

function ClearAllArtilleryTargets()
{
    local int i;

    for (i = 0; i < arraycount(GermanArtilleryTargets); ++i)
    {
        GermanArtilleryTargets[i].bIsActive = false;
    }

    for (i = 0; i < arraycount(AlliedArtilleryTargets); ++i)
    {
        AlliedArtilleryTargets[i].bIsActive = false;
    }
}

function ClearArtilleryTarget(DHPlayer PC)
{
    local int i;

    if (PC == none)
    {
        return;
    }

    for (i = 0; i < arraycount(GermanArtilleryTargets); ++i)
    {
        if (GermanArtilleryTargets[i].Controller == PC)
        {
            GermanArtilleryTargets[i].bIsActive = false;
            break;
        }
    }

    for (i = 0; i < arraycount(AlliedArtilleryTargets); ++i)
    {
        if (AlliedArtilleryTargets[i].Controller == PC)
        {
            AlliedArtilleryTargets[i].bIsActive = false;
            break;
        }
    }
}

function AddArtillery(DHArtillery Artillery)
{
    local int i;

    for (i = 0; i < arraycount(DHArtillery); ++i)
    {
        if (DHArtillery[i] == none)
        {
            DHArtillery[i] = Artillery;
            Log("added artillery at" @ i @ DHArtillery[i]);
            break;
        }
    }
}

function AddRadio(DHRadio Radio)
{
    local int i;

    for (i = 0; i < arraycount(Radios); ++i)
    {
        if (Radios[i] == none)
        {
            Radios[i] = Radio;
            break;
        }
    }
}

function RemoveRadio(DHRadio Radio)
{
    local int i;

    for (i = 0; i < arraycount(Radios); ++i)
    {
        if (Radios[i] == Radio)
        {
            Radios[i] = none;
        }
    }
}

//------------------------------------------------------------------------------
// Overhead Map Help Request Functions
//------------------------------------------------------------------------------

// Modified to avoid "accessed none" errors on PRI.Team
function AddRallyPoint(PlayerReplicationInfo PRI, vector NewLoc, optional bool bRemoveFromList)
{
    if (PRI != none && PRI.Team != none)
    {
        super.AddRallyPoint(PRI, NewLoc, bRemoveFromList);
    }
}

// Modified to avoid "accessed none" errors on PRI.Team
function AddHelpRequest(PlayerReplicationInfo PRI, int ObjectiveID, int RequestType, optional vector RequestLocation)
{
    if (PRI != none && PRI.Team != none)
    {
        super.AddHelpRequest(PRI, ObjectiveID, RequestType, RequestLocation);
    }
}

// Modified to fix incorrect RequestType used to identify resupply request (was 2, which is a defend objective request - should be 3)
function RemoveMGResupplyRequestFor(PlayerReplicationInfo PRI)
{
    local int i;

    if (PRI == none || PRI.Team == none)
    {
        return;
    }

    // Search request array to see if there's an MG resupply request for this player & clear it if there is
    if (PRI.Team.TeamIndex == AXIS_TEAM_INDEX)
    {
        for (i = 0; i < arraycount(AxisHelpRequests); ++i)
        {
            if (AxisHelpRequests[i].OfficerPRI == PRI && AxisHelpRequests[i].RequestType == 2)
            {
                AxisHelpRequests[i].OfficerPRI = none;
                AxisHelpRequests[i].RequestType = 255;
                break;
            }
        }
    }
    else if (PRI.Team.TeamIndex == ALLIES_TEAM_INDEX)
    {
        for (i = 0; i < arraycount(AlliedHelpRequests); ++i)
        {
            if (AlliedHelpRequests[i].OfficerPRI == PRI && AlliedHelpRequests[i].RequestType == 2)
            {
                AlliedHelpRequests[i].OfficerPRI = none;
                AlliedHelpRequests[i].RequestType = 255;
                break;
            }
        }
    }
}

//------------------------------------------------------------------------------
// Miscellaneous Functions
//------------------------------------------------------------------------------
// New helper function to calculate the round time remaining
// Avoids re-stating this logic in various functionality that display time remaining, e.g. scoreboard, overhead map, deploy screen & spectator HUD
simulated function int GetRoundTimeRemaining()
{
    local int SecondsRemaining;

    if (bMatchHasBegun)
    {
        SecondsRemaining = RoundEndTime - ElapsedTime;

        if (bRoundIsOver)
        {
            SecondsRemaining = RoundOverTime;
        }
    }
    else
    {
        SecondsRemaining = RoundStartTime + PreStartTime - ElapsedTime;
    }

    return Max(0, SecondsRemaining);
}

simulated function string GetTeamScaleString(int Team)
{
   local float     d;
   local int       i;

   if (Team == AXIS_TEAM_INDEX)
   {
       d = (1.0 - CurrentAlliedToAxisRatio) - (1.0 - (1.0 - CurrentAlliedToAxisRatio));
   }

   else if (Team == ALLIES_TEAM_INDEX)
   {
       d = CurrentAlliedToAxisRatio - (1.0 - CurrentAlliedToAxisRatio);
   }

   i = int(Round(d * 100));

   if (i > 0)
   {
       return "+" $ i $ "%";
   }
   else
   {
       return string(i) $ "%";
   }
}

// Modified to allow VoiceID to be greater than 32
simulated function AddPRI(PlayerReplicationInfo PRI)
{
    local byte      NewVoiceID;
    local int       i;

    if (Level.NetMode == NM_ListenServer || Level.NetMode == NM_DedicatedServer)
    {
        for (i = 0; i < PRIArray.Length; ++i)
        {
            if (PRIArray[i].VoiceID == NewVoiceID)
            {
                i = -1;
                ++NewVoiceID;
                continue;
            }
        }

        if (NewVoiceID >= VOICEID_MAX)
        {
            NewVoiceID = 0;
        }

        PRI.VoiceID = NewVoiceID;
    }

    PRIArray[PRIArray.Length] = PRI;
}

simulated function int GetTankReservationCount(int TeamIndex)
{
    local int i, Count;

    for (i = 0; i < arraycount(VehiclePoolReservationCount); ++i)
    {
        if (VehiclePoolVehicleClasses[i] != none &&
            VehiclePoolVehicleClasses[i].default.VehicleTeam == TeamIndex &&
            !IgnoresMaxTeamVehiclesFlags(i))
        {
            Count += VehiclePoolReservationCount[i];
        }
    }

    return Count;
}

simulated function int GetReservableTankCount(int TeamIndex)
{
    return MaxTeamVehicles[TeamIndex] - GetTankReservationCount(TeamIndex);
}

simulated function VehicleReservationError GetVehicleReservationError(DHPlayer PC, DHRoleInfo RI, int TeamIndex, int VehiclePoolIndex)
{
    local class<DHVehicle> VC;

    VC = class<DHVehicle>(GetVehiclePoolVehicleClass(VehiclePoolIndex));

    if (PC == none || RI == none || VC == none || (TeamIndex != AXIS_TEAM_INDEX && TeamIndex != ALLIES_TEAM_INDEX) || (PC.Pawn != none && PC.Pawn.Health > 0) || VC.default.VehicleTeam != RI.Side)
    {
        return ERROR_Fatal;
    }

    if (!RI.default.bCanBeTankCrew && VC.default.bMustBeTankCommander)
    {
        return ERROR_InvalidCredentials;
    }

    if (GetVehiclePoolSpawnsRemaining(VehiclePoolIndex) <= 0)
    {
        return ERROR_PoolOutOfSpawns;
    }

    if (!IsVehiclePoolActive(VehiclePoolIndex))
    {
        return ERROR_PoolInactive;
    }

    if (VehiclePoolActiveCounts[VehiclePoolIndex] >= VehiclePoolMaxActives[VehiclePoolIndex])
    {
        return ERROR_PoolMaxActive;
    }

    if (GetVehiclePoolAvailableReservationCount(VehiclePoolIndex) <= 0)
    {
        return ERROR_NoReservations;
    }

    if (VC.default.bMustBeInSquadToSpawn && !PC.IsInSquad())
    {
        return ERROR_NoSquad;
    }

    if (!IgnoresMaxTeamVehiclesFlags(VehiclePoolIndex) && GetReservableTankCount(TeamIndex) <= 0)
    {
        return ERROR_TeamMaxActive;
    }

    return ERROR_None;
}

// Overridden to undo the exclusion of players who hadn't yet selected a role.
simulated function GetTeamSizes(out int TeamSizes[2])
{
    local int i;
    local PlayerReplicationInfo PRI;

    TeamSizes[AXIS_TEAM_INDEX] = 0;
    TeamSizes[ALLIES_TEAM_INDEX] = 0;

    for (i = 0; i < PRIArray.Length; ++i)
    {
        PRI = PRIArray[i];

        if (PRI != none &&
            PRI.Team != none &&
            (PRI.Team.TeamIndex == AXIS_TEAM_INDEX || PRI.Team.TeamIndex == ALLIES_TEAM_INDEX))
        {
            ++TeamSizes[PRI.Team.TeamIndex];
        }
    }
}

//==============================================================================
// MAP MARKERS
//==============================================================================

simulated function bool GetMapMarker(int TeamIndex, int MapMarkerIndex, optional out DHGameReplicationInfo.MapMarker MapMarker)
{
    local DHGameReplicationInfo.MapMarker MM;

    if (MapMarkerIndex < 0 || MapMarkerIndex >= MAP_MARKERS_MAX)
    {
        return false;
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            MM = AxisMapMarkers[MapMarkerIndex];
            break;
        case ALLIES_TEAM_INDEX:
            MM = AlliesMapMarkers[MapMarkerIndex];
            break;
        default:
            return false;
    }

    if (MM.MapMarkerClass == none || (MM.ExpiryTime != -1 && MM.ExpiryTime <= ElapsedTime))
    {
       return false;
    }

    MapMarker = MM;
    return true;
}

simulated function GetMapMarkers(out array<MapMarker> MapMarkers, out array<int> Indices, int TeamIndex, int SquadIndex)
{
    local int i;

    GetMapMarkerIndices(Indices, TeamIndex, SquadIndex);

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            for (i = 0; i < Indices.Length; ++i)
            {
                MapMarkers[MapMarkers.Length] = AxisMapMarkers[Indices[i]];
            }
            break;
        case ALLIES_TEAM_INDEX:
            for (i = 0; i < Indices.Length; ++i)
            {
                MapMarkers[MapMarkers.Length] = AlliesMapMarkers[Indices[i]];
            }
            break;
    }
}

simulated function GetMapMarkerIndices(out array<int> Indices, int TeamIndex, int SquadIndex)
{
    local int i;

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            for (i = 0; i < arraycount(AxisMapMarkers); ++i)
            {
                if (AxisMapMarkers[i].MapMarkerClass != none &&
                    (AxisMapMarkers[i].ExpiryTime == -1 || AxisMapMarkers[i].ExpiryTime > ElapsedTime) &&
                    (AxisMapMarkers[i].SquadIndex == 255 || AxisMapMarkers[i].SquadIndex == SquadIndex))
                {
                    Indices[Indices.Length] = i;
                }
            }
            break;
        case ALLIES_TEAM_INDEX:
            for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
            {
                if (AlliesMapMarkers[i].MapMarkerClass != none &&
                    (AlliesMapMarkers[i].ExpiryTime == -1 || AlliesMapMarkers[i].ExpiryTime > ElapsedTime) &&
                    (AlliesMapMarkers[i].SquadIndex == 255 || AlliesMapMarkers[i].SquadIndex == SquadIndex))
                {
                    Indices[Indices.Length] = i;
                }
            }
            break;
    }
}

function int AddMapMarker(DHPlayerReplicationInfo PRI, class<DHMapMarker> MapMarkerClass, vector MapLocation)
{
    local int i;
    local MapMarker M;

    if (PRI == none || PRI.Team == none || MapMarkerClass == none || !MapMarkerClass.static.CanBeUsed(self) || !MapMarkerClass.static.CanPlayerUse(PRI))
    {
        return -1;
    }

    M.MapMarkerClass = MapMarkerClass;

    // Quantize map-space coordinates for transmission.
    M.LocationX = byte(255.0 * FClamp(MapLocation.X, 0.0, 1.0));
    M.LocationY = byte(255.0 * FClamp(MapLocation.Y, 0.0, 1.0));

    if (MapMarkerClass.default.bIsSquadSpecific)
    {
        M.SquadIndex = PRI.SquadIndex;
    }
    else
    {
        M.SquadIndex = -1;
    }

    if (MapMarkerClass.default.LifetimeSeconds != -1)
    {
        M.ExpiryTime = ElapsedTime + MapMarkerClass.default.LifetimeSeconds;
    }
    else
    {
        M.ExpiryTime = -1;
    }

    switch (PRI.Team.TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            if (MapMarkerClass.default.bShouldOverwriteGroup)
            {
                for (i = 0; i < arraycount(AxisMapMarkers); ++i)
                {
                    if (AxisMapMarkers[i].MapMarkerClass != none &&
                        AxisMapMarkers[i].MapMarkerClass.default.GroupIndex == MapMarkerClass.default.GroupIndex &&
                        AxisMapMarkers[i].SquadIndex == -1 || AxisMapMarkers[i].SquadIndex == PRI.SquadIndex)
                    {
                        AxisMapMarkers[i] = M;
                        MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                        return i;
                    }
                }
            }

            if (MapMarkerClass.default.bIsUnique)
            {
                for (i = 0; i < arraycount(AxisMapMarkers); ++i)
                {
                    if (AxisMapMarkers[i].MapMarkerClass == MapMarkerClass &&
                        (!MapMarkerClass.default.bIsSquadSpecific ||
                         (MapMarkerClass.default.bIsSquadSpecific && AxisMapMarkers[i].SquadIndex == PRI.SquadIndex)))
                    {
                        AxisMapMarkers[i] = M;
                        MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                        return i;
                    }
                }
            }

            for (i = 0; i < arraycount(AxisMapMarkers); ++i)
            {
                if (AxisMapMarkers[i].MapMarkerClass == none ||
                    (AxisMapMarkers[i].ExpiryTime != -1 &&
                     AxisMapMarkers[i].ExpiryTime <= ElapsedTime))
                {
                    AxisMapMarkers[i] = M;
                    MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                    return i;
                }
            }
            break;

        case ALLIES_TEAM_INDEX:
            if (MapMarkerClass.default.bShouldOverwriteGroup)
            {
                for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
                {
                    if (AlliesMapMarkers[i].MapMarkerClass != none &&
                        AlliesMapMarkers[i].MapMarkerClass.default.GroupIndex == MapMarkerClass.default.GroupIndex &&
                        AlliesMapMarkers[i].SquadIndex == -1 || AlliesMapMarkers[i].SquadIndex == PRI.SquadIndex)
                    {
                        AlliesMapMarkers[i] = M;
                        MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                        return i;
                    }
                }
            }

            if (MapMarkerClass.default.bIsUnique)
            {
                for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
                {
                    if (AlliesMapMarkers[i].MapMarkerClass == MapMarkerClass &&
                        (!MapMarkerClass.default.bIsSquadSpecific ||
                         (MapMarkerClass.default.bIsSquadSpecific && AlliesMapMarkers[i].SquadIndex == PRI.SquadIndex)))
                    {
                        AlliesMapMarkers[i] = M;
                        MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                        return i;
                    }
                }
            }

            for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
            {
                if (AlliesMapMarkers[i].MapMarkerClass == none ||
                    (AlliesMapMarkers[i].ExpiryTime != -1 &&
                     AlliesMapMarkers[i].ExpiryTime <= ElapsedTime))
                {
                    AlliesMapMarkers[i] = M;
                    MapMarkerClass.static.OnMapMarkerPlaced(DHPlayer(PRI.Owner));
                    return i;
                }
            }
            break;
    }

    return -1;
}

function RemoveMapMarker(int TeamIndex, int MapMarkerIndex)
{
    if (MapMarkerIndex < 0 || MapMarkerIndex >= MAP_MARKERS_MAX)
    {
        return;
    }

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            AxisMapMarkers[MapMarkerIndex].MapMarkerClass = none;
            break;
        case ALLIES_TEAM_INDEX:
            AlliesMapMarkers[MapMarkerIndex].MapMarkerClass = none;
            break;
        default:
            break;
    }
}

function ClearSquadMapMarkers(int TeamIndex, int SquadIndex)
{
    local int i;

    switch (TeamIndex)
    {
        case AXIS_TEAM_INDEX:
            for (i = 0; i < arraycount(AxisMapMarkers); ++i)
            {
                if (AxisMapMarkers[i].SquadIndex == SquadIndex)
                {
                    AxisMapMarkers[i].MapMarkerClass = none;
                }
            }
            break;
        case ALLIES_TEAM_INDEX:
            for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
            {
                if (AlliesMapMarkers[i].SquadIndex == SquadIndex)
                {
                    AlliesMapMarkers[i].MapMarkerClass = none;
                }
            }
            break;
    }
}

function ClearMapMarkers()
{
    local int i;

    for (i = 0; i < arraycount(AxisMapMarkers); ++i)
    {
        AxisMapMarkers[i].MapMarkerClass = none;
    }

    for (i = 0; i < arraycount(AlliesMapMarkers); ++i)
    {
        AlliesMapMarkers[i].MapMarkerClass = none;
    }
}

// Gets the map coordindates (0..1) from a world location.
simulated function GetMapCoords(vector WorldLocation, out float X, out float Y, optional float Width, optional float Height)
{
    local float  MapScale;
    local vector MapCenter;

    MapScale = FMax(1.0, Abs((SouthWestBounds - NorthEastBounds).X));
    MapCenter = NorthEastBounds + ((SouthWestBounds - NorthEastBounds) * 0.5);
    WorldLocation = GetAdjustedHudLocation(WorldLocation - MapCenter, false);

    X = 1.0 - FClamp(0.5 + (WorldLocation.X / MapScale) - (Width / 2),
                     0.0,
                     1.0 - Width);

    Y = 1.0 - FClamp(0.5 + (WorldLocation.Y / MapScale) - (Height / 2),
                     0.0,
                     1.0 - Height);
}

// Gets the world location from map coordinates.
simulated function vector GetWorldCoords(float X, float Y)
{
    local float MapScale;
    local vector MapCenter, WorldLocation;

    MapScale = FMax(1.0, Abs((SouthWestBounds - NorthEastBounds).X));
    MapCenter = NorthEastBounds + ((SouthWestBounds - NorthEastBounds) * 0.5);
    WorldLocation.X = ((0.5 - X) * MapScale);
    WorldLocation.Y = ((0.5 - Y) * MapScale);
    WorldLocation = GetAdjustedHudLocation(WorldLocation, true);
    WorldLocation += MapCenter;

    return WorldLocation;
}

// This function will adjust a hud map location based on the rotation offset of
// the overhead map.
// NOTE: This is functionally identical to same function in ROHud. It has been
// moved here because it had no business being in that class since it only
// referenced things in the GRI class.
simulated function vector GetAdjustedHudLocation(vector HudLoc, optional bool bInvert)
{
    local float SwapX, SwapY;
    local int Offset;

    Offset = OverheadOffset;

    if (bInvert)
    {
        if (OverheadOffset == 90)
        {
            Offset = 270;
        }
        else if (OverheadOffset == 270)
        {
            Offset = 90;
        }
    }

    if (Offset == 90)
    {
        SwapX = HudLoc.Y * -1;
        SwapY = HudLoc.X;
        HudLoc.X = SwapX;
        HudLoc.Y = SwapY;
    }
    else if (Offset == 180)
    {
        SwapX = HudLoc.X * -1;
        SwapY = HudLoc.Y * -1;
        HudLoc.X = SwapX;
        HudLoc.Y = SwapY;
    }
    else if (Offset == 270)
    {
        SwapX = HudLoc.Y;
        SwapY = HudLoc.X * -1;
        HudLoc.X = SwapX;
        HudLoc.Y = SwapY;
    }

    return HudLoc;
}

simulated function EArtilleryTypeError GetArtilleryTypeError(DHPlayer PC, int ArtilleryTypeIndex)
{
    local ArtilleryTypeInfo ATI;
    local DH_LevelInfo LI;

    LI = class'DH_LevelInfo'.static.GetInstance(Level);

    if (PC == none || LI == none ||
        ArtilleryTypeIndex < 0 ||
        ArtilleryTypeIndex >= arraycount(ArtilleryTypeInfos) ||
        LI.ArtilleryTypes[ArtilleryTypeIndex].ArtilleryClass == none ||
        LI.ArtilleryTypes[ArtilleryTypeIndex].TeamIndex != PC.GetTeamNum())
    {
        return ERROR_Fatal;
    }

    if (!LI.ArtilleryTypes[ArtilleryTypeIndex].ArtilleryClass.static.CanBeRequestedBy(PC))
    {
        return ERROR_Unqualified;
    }

    ATI = ArtilleryTypeInfos[ArtilleryTypeIndex];

    if (!ATI.bIsAvailable)
    {
        return ERROR_Unavailable;
    }
    else if (ATI.UsedCount >= ATI.Limit)
    {
        return ERROR_Exhausted;
    }
    else if (ATI.ArtilleryActor != none)
    {
        return ERROR_Ongoing;
    }
    else if (ElapsedTime < ATI.NextConfirmElapsedTime)
    {
        return ERROR_Cooldown;
    }

    return ERROR_None;
}

defaultproperties
{
    bAllowAllChat=true
    AlliesVictoryMusicIndex=-1
    AxisVictoryMusicIndex=-1
    ArtilleryTargetDistanceThreshold=15088 //250 meters in UU
    ForceScaleText="Size"
    ReinforcementsInfiniteText="Infinite"

    // Constructions

    // Logistics
    ConstructionClassNames(0)="DH_Construction.DHConstruction_SupplyCache"
    ConstructionClassNames(1)="DH_Construction.DHConstruction_PlatoonHQ"
    ConstructionClassNames(2)="DH_Construction.DHConstruction_Resupply_Players"
    ConstructionClassNames(3)="DH_Construction.DHConstruction_Resupply_Vehicles"
    ConstructionClassNames(4)="DH_Construction.DHConstruction_Radio"
    //ConstructionClassNames(5)="DH_Construction.DHConstruction_VehiclePool"

    // Obstacles
    ConstructionClassNames(6)="DH_Construction.DHConstruction_ConcertinaWire"
    ConstructionClassNames(7)="DH_Construction.DHConstruction_Hedgehog"

    // Guns
    ConstructionClassNames(8)="DH_Construction.DHConstruction_ATGun_Medium"
    ConstructionClassNames(9)="DH_Construction.DHConstruction_ATGun_Heavy"
    ConstructionClassNames(10)="DH_Construction.DHConstruction_AAGun_Light"
    ConstructionClassNames(11)="DH_Construction.DHConstruction_AAGun_Medium"

    // Defenses
    ConstructionClassNames(12)="DH_Construction.DHConstruction_Foxhole"
    ConstructionClassNames(13)="DH_Construction.DHConstruction_Sandbags_Line"
    ConstructionClassNames(14)="DH_Construction.DHConstruction_Sandbags_Crescent"
    ConstructionClassNames(15)="DH_Construction.DHConstruction_Sandbags_Bunker"
    ConstructionClassNames(16)="DH_Construction.DHConstruction_Watchtower"
    ConstructionClassNames(17)="DH_Construction.DHConstruction_GrenadeCrate"
    //ConstructionClassNames(17)="DH_Construction.DHConstruction_MortarPit"

    // Map Markers
    MapMarkerClassNames(0)="DH_Engine.DHMapMarker_Squad_Move"
    MapMarkerClassNames(1)="DH_Engine.DHMapMarker_Squad_Attack"
    MapMarkerClassNames(2)="DH_Engine.DHMapMarker_Squad_Defend"
    MapMarkerClassNames(3)="DH_Engine.DHMapMarker_Enemy_PlatoonHQ"
    MapMarkerClassNames(4)="DH_Engine.DHMapMarker_Enemy_Infantry"
    MapMarkerClassNameS(5)="DH_Engine.DHMapMarker_Enemy_Vehicle"
    MapMarkerClassNames(6)="DH_Engine.DHMapMarker_Enemy_Tank"
    MapMarkerClassNames(7)="DH_Engine.DHMapMarker_Enemy_ATGun"
    MapMarkerClassNames(8)="DH_Engine.DHMapMarker_Friendly_PlatoonHQ"
    MapMarkerClassNames(9)="DH_Engine.DHMapMarker_Friendly_Supplies"
}
