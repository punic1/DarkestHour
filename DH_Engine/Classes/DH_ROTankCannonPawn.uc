//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_ROTankCannonPawn extends ROTankCannonPawn
    abstract;

// General
var     DH_ROTankCannon Cannon;               // just a reference to the DH cannon actor, for convenience & to avoid lots of casts
var     texture         AltAmmoReloadTexture; // used to show coaxial MG reload progress on the HUD, like the cannon reload

// Position stuff
var     int         InitialPositionIndex;     // initial commander position on entering
var     int         UnbuttonedPositionIndex;  // lowest position number where player is unbuttoned
var()   int         PeriscopePositionIndex;
var     int         GunsightPositions;        // the number of gunsight positions - 1 for normal optics or 2 for dual-magnification optics

// Gunsight or periscope overlay
var     bool        bShowRangeText;       // show current range setting text
var     TexRotator  ScopeCenterRotator;
var()   float       ScopeCenterScale;
var()   int         CenterRotationFactor;
var()   float       OverlayCenterSize;    // size of the gunsight overlay, 1.0 means full screen width, 0.5 means half screen width
var     float       OverlayCenterScale;
var()   float       OverlayCorrectionX;   // scope center correction in pixels, in case an overlay is off-center by pixel or two
var()   float       OverlayCorrectionY;

// Damage modelling stuff
var     bool        bTurretRingDamaged;
var     bool        bGunPivotDamaged;
var     bool        bOpticsDamaged;
var     texture     DestroyedScopeOverlay;

// Manual & powered turret movement
var     bool        bManualTraverseOnly;
var     sound       ManualRotateSound;
var     sound       ManualPitchSound;
var     sound       ManualRotateAndPitchSound;
var     sound       PoweredRotateSound;
var     sound       PoweredPitchSound;
var     sound       PoweredRotateAndPitchSound;
var     float       ManualMinRotateThreshold;
var     float       ManualMaxRotateThreshold;
var     float       PoweredMinRotateThreshold;
var     float       PoweredMaxRotateThreshold;

// NEW DH CODE: Illuminated sights
//var   texture     NormalCannonScopeOverlay;
//var   texture     LitCannonScopeOverlay; // a ClientLightOverlay() server-to-client function was planned
//var   bool        bOpticsLit;
//var   bool        bHasLightedOptics;

// Debugging help
var()   bool        bShowCenter;    // shows centering cross in tank sight for testing purposes
var     bool        bDebuggingText; // on screen messages if damage prevents turret or gun from moving properly
var     bool        bDebugExitPositions;

replication
{
    // Variables the server will replicate to all clients
    reliable if (bNetDirty && Role == ROLE_Authority)
        bTurretRingDamaged, bGunPivotDamaged;
//      UnbuttonedPositionIndex;      // Matt: removed as never changes & doesn't need to be replicated
//      bOpticsDamaged; // bOpticsLit // Matt: removed as not even used clientside

    // Functions a client can call on the server
    reliable if (Role < ROLE_Authority)
        ServerChangeDriverPos, ServerToggleDebugExits, ServerToggleDriverDebug;
//      ServerToggleExtraRoundType // Matt: removed as is pointless - the normal RO ServerToggleRoundType can be called; it's only the functionality in Gun.ToggleRoundType() that changes
//      DamageCannonOverlay        // Matt: removed as isn't called by client

    // Functions the server can call on the client that owns this actor
    reliable if (Role == ROLE_Authority)
        ClientDamageCannonOverlay;
}

// Modified to use new, simplified system with exit positions for all vehicle positions included in the vehicle class default properties
function bool PlaceExitingDriver()
{
    local int    i, StartIndex;
    local vector Extent, HitLocation, HitNormal, ZOffset, ExitPosition;

    if (Driver == none)
    {
        return false;
    }

    Extent = Driver.default.CollisionRadius * vect(1.0, 1.0, 0.0);
    Extent.Z = Driver.default.CollisionHeight;
    ZOffset = Driver.default.CollisionHeight * vect(0.0, 0.0, 0.5);

    if (VehicleBase == none)
    {
        return false;
    }

    // Debug exits - uses abstract class default, allowing bDebugExitPositions to be toggled for all MG pawns
    if (class'DH_ROTankCannonPawn'.default.bDebugExitPositions)
    {
        for (i = 0; i < VehicleBase.ExitPositions.Length; ++i)
        {
            ExitPosition = VehicleBase.Location + (VehicleBase.ExitPositions[i] >> VehicleBase.Rotation) + ZOffset;

            Spawn(class'DH_DebugTracer',,, ExitPosition);
        }
    }

    i = Clamp(PositionInArray + 1, 0, VehicleBase.ExitPositions.Length - 1);
    StartIndex = i;

    while (i >= 0 && i < VehicleBase.ExitPositions.Length)
    {
        ExitPosition = VehicleBase.Location + (VehicleBase.ExitPositions[i] >> VehicleBase.Rotation) + ZOffset;

        if (Trace(HitLocation, HitNormal, ExitPosition, VehicleBase.Location + ZOffset, false, Extent) == none &&
            Trace(HitLocation, HitNormal, ExitPosition, ExitPosition + ZOffset, false, Extent) == none &&
            Driver.SetLocation(ExitPosition))
        {
            return true;
        }

        ++i;

        if (i == StartIndex)
        {
            break;
        }
        else if (i == VehicleBase.ExitPositions.Length)
        {
            i = 0;
        }
    }

    return false;
}

// Matt: modified to call InitializeCannon when we've received both the replicated Gun & VehicleBase actors (just after vehicle spawns via replication), which has 2 benefits:
// 1. Do things that need one or both of those actor refs, controlling common problem of unpredictability of timing of receiving replicated actor references
// 2. To do any extra set up in the cannon classes, which can easily be subclassed for anything that is vehicle specific
simulated function PostNetReceive()
{
    local int i;

    // Player has changed position // Matt: TODO - add fix for driver position problems upon replication
    if (DriverPositionIndex != SavedPositionIndex && Gun != none && bMultiPosition)
    {
        if (Driver == none && DriverPositionIndex > 0 && !IsLocallyControlled() && Level.NetMode == NM_Client)
        {
            // do nothing
        }
        else
        {

            LastPositionIndex = SavedPositionIndex;
            SavedPositionIndex = DriverPositionIndex;
            NextViewPoint();
        }
    }

    // Initialize the cannon (added VehicleBase != none, so we guarantee that VB is available to InitializeCannon)
    if (!bInitializedVehicleGun && Gun != none && VehicleBase != none)
    {
        bInitializedVehicleGun = true;
        InitializeCannon();
    }

    // Initialize the vehicle base
    if (!bInitializedVehicleBase && VehicleBase != none)
    {
        bInitializedVehicleBase = true;

        // On client, this actor is destroyed if becomes net irrelevant - when it respawns, empty WeaponPawns array needs filling again or will cause lots of errors
        if (VehicleBase.WeaponPawns.Length > 0 && VehicleBase.WeaponPawns.Length > PositionInArray &&
            (VehicleBase.WeaponPawns[PositionInArray] == none || VehicleBase.WeaponPawns[PositionInArray].default.Class == none))
        {
            VehicleBase.WeaponPawns[PositionInArray] = self;

            return;
        }

        for (i = 0; i < VehicleBase.WeaponPawns.Length; ++i)
        {
            if (VehicleBase.WeaponPawns[i] != none && (VehicleBase.WeaponPawns[i] == self || VehicleBase.WeaponPawns[i].Class == class))
            {
                return;
            }
        }

        VehicleBase.WeaponPawns[PositionInArray] = self;
    }
}

// Modified to call InitializeCannon to do any extra set up in the cannon classes
// This is where we do it for standalones or servers (note we can't do it in PostNetBeginPlay because VehicleBase isn't set until this function is called)
function AttachToVehicle(ROVehicle VehiclePawn, name WeaponBone)
{
    super.AttachToVehicle(VehiclePawn, WeaponBone);

    if (Role == ROLE_Authority)
    {
        InitializeCannon();
    }
}

// Matt: new function to do any extra set up in the cannon classes (called from PostNetReceive on net client or from AttachToVehicle on standalone or server)
// Crucially, we know that we have VehicleBase & Gun when this function gets called, so we can reliably do stuff that needs those actors
// Using it to reliably initialize the manual/powered turret settings when vehicle spawns, knowing we'll have relevant actors
simulated function InitializeCannon()
{
    Cannon = DH_ROTankCannon(Gun);

    if (Cannon != none)
    {
        Cannon.InitializeCannon(self);
    }
    else
    {
        Warn("ERROR:" @ Tag @ "somehow spawned without an owned DH_ROTankCannon, so lots of things are not going to work!");
    }

    if (DH_ROTreadCraft(VehicleBase) != none)
    {
        SetManualTurret(DH_ROTreadCraft(VehicleBase).bEngineOff);
    }
    else
    {
        SetManualTurret(true);
    }
}

// New function to toggle between manual/powered turret settings - called from PostNetReceive on vehicle clients, instead of constantly checking in Tick()
simulated function SetManualTurret(bool bManual)
{
    if (bManual || bManualTraverseOnly)
    {
        RotateSound = ManualRotateSound;
        PitchSound = ManualPitchSound;
        RotateAndPitchSound = ManualRotateAndPitchSound;
        MinRotateThreshold = ManualMinRotateThreshold;
        MaxRotateThreshold = ManualMaxRotateThreshold;

        if (Cannon != none)
        {
            Cannon.RotationsPerSecond = Cannon.ManualRotationsPerSecond;
        }
    }
    else
    {
        RotateSound = PoweredRotateSound;
        PitchSound = PoweredPitchSound;
        RotateAndPitchSound = PoweredRotateAndPitchSound;
        MinRotateThreshold = PoweredMinRotateThreshold;
        MaxRotateThreshold = PoweredMaxRotateThreshold;

        if (Cannon != none)
        {
            Cannon.RotationsPerSecond = Cannon.PoweredRotationsPerSecond;
        }
    }
}

// New function to damage gunsight optics
function DamageCannonOverlay()
{
    ClientDamageCannonOverlay();
    bOpticsDamaged = true;
}

simulated function ClientDamageCannonOverlay()
{
    CannonScopeOverlay = DestroyedScopeOverlay;
}

// Modified to allow turret traverse or elevation seizure if turret ring or pivot are damaged
function HandleTurretRotation(float DeltaTime, float YawChange, float PitchChange)
{
    if (bTurretRingDamaged)
    {
        if (bGunPivotDamaged)
        {
            if (bDebuggingText && Role == ROLE_Authority)
            {
                Level.Game.Broadcast(self, "Gun & turret disabled");
            }

            super.HandleTurretRotation(DeltaTime, 0.0, 0.0);
        }
        else
        {
            if (bDebuggingText && Role == ROLE_Authority)
            {
                Level.Game.Broadcast(self, "Turret disabled");
            }

            super.HandleTurretRotation(DeltaTime, 0.0, PitchChange);
        }
    }
    else if (bGunPivotDamaged)
    {
        if (bDebuggingText && Role == ROLE_Authority)
        {
            Level.Game.Broadcast(self, "Gun pivot disabled");
        }

        super.HandleTurretRotation(DeltaTime, YawChange, 0.0);
    }
    else // no damage
    {
        super.HandleTurretRotation(DeltaTime, YawChange, PitchChange);
    }
}

// Modified to handle dual-magnification optics (DPI < GunsightPositions), & to apply FPCamPos to all positions not just overlay positions
simulated function SpecialCalcFirstPersonView(PlayerController PC, out actor ViewActor, out vector CameraLocation, out rotator CameraRotation)
{
    local vector  x, y, z, VehicleZ, CamViewOffsetWorld;
    local float   CamViewOffsetZAmount;
    local coords  CamBoneCoords;
    local rotator WeaponAimRot;
    local quat    AQuat, BQuat, CQuat;

    GetAxes(CameraRotation, x, y, z);
    ViewActor = self;

    WeaponAimRot = rotator(vector(Gun.CurrentAim) >> Gun.Rotation);
    WeaponAimRot.Roll =  VehicleBase.Rotation.Roll;

    if (ROPlayer(Controller) != none)
    {
        ROPlayer(Controller).WeaponBufferRotation.Yaw = WeaponAimRot.Yaw;
        ROPlayer(Controller).WeaponBufferRotation.Pitch = WeaponAimRot.Pitch;
    }

    // This makes the camera stick to the cannon, but you have no control
    if (DriverPositionIndex < GunsightPositions)
    {
        CameraRotation = WeaponAimRot;
        CameraRotation.Roll = 0; // make the cannon view have no roll
    }
    else if (bPCRelativeFPRotation)
    {
        // First, rotate the headbob by the PlayerController's rotation (looking around)
        AQuat = QuatFromRotator(PC.Rotation);
        BQuat = QuatFromRotator(HeadRotationOffset - ShiftHalf);
        CQuat = QuatProduct(AQuat,BQuat);

        // Then, rotate that by the vehicles rotation to get the final rotation
        AQuat = QuatFromRotator(VehicleBase.Rotation);
        BQuat = QuatProduct(CQuat,AQuat);

        // Finally, make it back into a rotator
        CameraRotation = QuatToRotator(BQuat);
    }
    else
    {
        CameraRotation = PC.Rotation;
    }

    if (IsInState('ViewTransition') && bLockCameraDuringTransition)
    {
        CameraRotation = Gun.GetBoneRotation('Camera_com');
    }

    CamViewOffsetWorld = FPCamViewOffset >> CameraRotation;

    if (CameraBone != '' && Gun != none)
    {
        CamBoneCoords = Gun.GetBoneCoords(CameraBone);

        if (DriverPositions[DriverPositionIndex].bDrawOverlays && DriverPositionIndex < GunsightPositions && !IsInState('ViewTransition'))
        {
            CameraLocation = CamBoneCoords.Origin + (FPCamPos >> WeaponAimRot) + CamViewOffsetWorld;
        }
        else
        {
            CameraLocation = Gun.GetBoneCoords('Camera_com').Origin + (FPCamPos >> WeaponAimRot) + CamViewOffsetWorld;
        }

        if (bFPNoZFromCameraPitch)
        {
            VehicleZ = vect(0.0, 0.0, 1.0) >> WeaponAimRot;
            CamViewOffsetZAmount = CamViewOffsetWorld dot VehicleZ;
            CameraLocation -= CamViewOffsetZAmount * VehicleZ;
        }
    }
    else
    {
        CameraLocation = GetCameraLocationStart() + (FPCamPos >> Rotation) + CamViewOffsetWorld;

        if (bFPNoZFromCameraPitch)
        {
            VehicleZ = vect(0.0, 0.0, 1.0) >> Rotation;
            CamViewOffsetZAmount = CamViewOffsetWorld dot VehicleZ;
            CameraLocation -= CamViewOffsetZAmount * VehicleZ;
        }
    }

    CameraRotation = Normalize(CameraRotation + PC.ShakeRot);
    CameraLocation = CameraLocation + PC.ShakeOffset.X * x + PC.ShakeOffset.Y * y + PC.ShakeOffset.Z * z;
}

// Modified to simply draw the BinocsOverlay, without additional drawing
simulated function DrawBinocsOverlay(Canvas Canvas)
{
    local float ScreenRatio;

    ScreenRatio = Float(Canvas.SizeY) / Float(Canvas.SizeX);
    Canvas.SetPos(0.0, 0.0);
    Canvas.DrawTile(BinocsOverlay, Canvas.SizeX, Canvas.SizeY, 0.0, (1.0 - ScreenRatio) * Float(BinocsOverlay.VSize) / 2.0, BinocsOverlay.USize, Float(BinocsOverlay.VSize) * ScreenRatio);
}

// Recalls that optics are still non-functioning when players jump in and out
function KDriverEnter(Pawn P)
{
    super.KDriverEnter(P);

    if (bOpticsDamaged)
    {
        ClientDamageCannonOverlay();
    }
}

// Modified to handle InitialPositionIndex instead of assuming start in position zero
// Also so cannon retains its aimed direction when player enters & may switch to internal mesh // Matt: TEST
simulated state EnteringVehicle
{
    simulated function HandleEnter()
    {
        SwitchMesh(InitialPositionIndex);

        if (Gun != none && Gun.HasAnim(Gun.BeginningIdleAnim))
        {
            Gun.PlayAnim(Gun.BeginningIdleAnim); // shouldn't actually be necessary, but a reasonable fail-safe
        }

        WeaponFOV = DriverPositions[InitialPositionIndex].ViewFOV;
        PlayerController(Controller).SetFOV(WeaponFOV);

        FPCamPos = DriverPositions[InitialPositionIndex].ViewLocation;
    }
}

// Modified to handle InitialPositionIndex instead of assuming start in position zero, & to match rotation to cannon's aim (also consolidates & optimises the Supers)
simulated function ClientKDriverEnter(PlayerController PC)
{

    if (bMultiPosition)
    {
        Gotostate('EnteringVehicle');
        PendingPositionIndex = InitialPositionIndex;
        ServerChangeDriverPos();
    }
    else
    {
        PC.SetFOV(WeaponFOV);
    }

    StoredVehicleRotation = VehicleBase.Rotation; // Matt: I don't think this is used anywhere & will probably remove from all functions later

    super(Vehicle).ClientKDriverEnter(PC);

    MatchRotationToGunAim();
}

function ServerChangeDriverPos()
{
    DriverPositionIndex = InitialPositionIndex;
}

// Modified to prevent players exiting unless unbuttoned
// Also to reset to InitialPositionIndex instead of zero & so that exit stuff only happens if the Super returns true
function bool KDriverLeave(bool bForceLeave)
{
    if (!bForceLeave && !CanExit()) // bForceLeave means so player is trying to exit not just switch position, so no risk of locking someone in one slot
    {
        return false;
    }

    if (super(VehicleWeaponPawn).KDriverLeave(bForceLeave))
    {
        DriverPositionIndex = InitialPositionIndex;
        LastPositionIndex = InitialPositionIndex;

        VehicleBase.MaybeDestroyVehicle();

        return true;
    }

    return false;
}

// Modified to reset to InitialPositionIndex instead of zero & to call DriverLeft() because player death doesn't trigger KDriverLeave/DriverLeft/DrivingStatusChanged
function DriverDied()
{
    DriverPositionIndex = InitialPositionIndex;

    super(Vehicle).DriverDied(); // need to skip over Super in ROVehicleWeaponPawn (& Super in VehicleWeaponPawn adds nothing)

    VehicleBase.MaybeDestroyVehicle();

    if (VehicleBase.Health > 0)
    {
        SetRotatingStatus(0); // kill the rotation sound if the driver dies but the vehicle doesn't
    }

    DriverLeft(); // fix Unreal bug (as done in ROVehicle), as DriverDied should call DriverLeft, the same as KDriverLeave does
}

// Modified to play idle anim on all net modes, to reset visuals like hatches & any moving collision boxes (was only playing on owning net client, not server or other clients)
simulated event DrivingStatusChanged()
{
    super.DrivingStatusChanged();

    if (!bDriving && Gun != none && Gun.HasAnim(Gun.BeginningIdleAnim))
    {
        Gun.PlayAnim(Gun.BeginningIdleAnim);
    }
}

// Modified to avoid wasting network resources by calling ServerChangeViewPoint on the server when it isn't valid
simulated function NextWeapon()
{
    if (DriverPositionIndex < DriverPositions.Length - 1 && DriverPositionIndex == PendingPositionIndex && !IsInState('ViewTransition') && bMultiPosition)
    {
        PendingPositionIndex = DriverPositionIndex + 1;
        ServerChangeViewPoint(true);
    }
}

simulated function PrevWeapon()
{
    if (DriverPositionIndex > 0 && DriverPositionIndex == PendingPositionIndex && !IsInState('ViewTransition') && bMultiPosition)
    {
        PendingPositionIndex = DriverPositionIndex -1;
        ServerChangeViewPoint(false);
    }
}

// Modified so server goes to state ViewTransition when unbuttoning, preventing player exiting until fully unbuttoned
function ServerChangeViewPoint(bool bForward)
{
    if (bForward)
    {
        if (DriverPositionIndex < (DriverPositions.Length - 1))
        {
            LastPositionIndex = DriverPositionIndex;
            DriverPositionIndex++;

            if (Level.NetMode == NM_Standalone  || Level.NetMode == NM_ListenServer)
            {
                NextViewPoint();
            }
            else if (Level.NetMode == NM_DedicatedServer)
            {
                if (DriverPositionIndex == UnbuttonedPositionIndex)
                {
                    GoToState('ViewTransition');
                }
            }
        }
    }
    else
    {
        if (DriverPositionIndex > 0)
        {
            LastPositionIndex = DriverPositionIndex;
            DriverPositionIndex--;

            if (Level.NetMode == NM_Standalone || Level.NetMode == NM_ListenServer)
            {
                NextViewPoint();
            }
        }
    }
}

simulated state ViewTransition
{
    simulated function HandleTransition()
    {
        // Added so when player moves up from gunsight, rotation is set to match the direction cannon is facing (feels more natural to come up from the cannon)
        if (LastPositionIndex < GunsightPositions && DriverPositionIndex >= GunsightPositions)
        {
            MatchRotationToGunAim();
        }

        StoredVehicleRotation = VehicleBase.Rotation;

        SwitchMesh(DriverPositionIndex);

        if (Driver != none && Driver.HasAnim(DriverPositions[DriverPositionIndex].DriverTransitionAnim) && Driver.HasAnim(DriverPositions[LastPositionIndex].DriverTransitionAnim))
        {
            Driver.PlayAnim(DriverPositions[DriverPositionIndex].DriverTransitionAnim);
        }

        WeaponFOV = DriverPositions[DriverPositionIndex].ViewFOV;

        FPCamPos = DriverPositions[DriverPositionIndex].ViewLocation;

        if (DriverPositionIndex != 0)
        {
            if (DriverPositions[DriverPositionIndex].bDrawOverlays)
            {
                PlayerController(Controller).SetFOV(WeaponFOV);
            }
            else
            {
                PlayerController(Controller).DesiredFOV = WeaponFOV;
            }
        }

        if (LastPositionIndex < DriverPositionIndex)
        {
            if (Gun.HasAnim(DriverPositions[LastPositionIndex].TransitionUpAnim))
            {
                Gun.PlayAnim(DriverPositions[LastPositionIndex].TransitionUpAnim);
                SetTimer(Gun.GetAnimDuration(DriverPositions[LastPositionIndex].TransitionUpAnim, 1.0), false);
            }
            else
            {
                GotoState('');
            }
        }
        else if (Gun.HasAnim(DriverPositions[LastPositionIndex].TransitionDownAnim))
        {
            Gun.PlayAnim(DriverPositions[LastPositionIndex].TransitionDownAnim);
            SetTimer(Gun.GetAnimDuration(DriverPositions[LastPositionIndex].TransitionDownAnim, 1.0), false);
        }
        else
        {
            GotoState('');
        }
    }

    simulated function Timer()
    {
        GotoState('');
    }

    simulated function AnimEnd(int channel)
    {
        if (IsLocallyControlled())
        {
            GotoState('');
        }
    }

    simulated function EndState()
    {
        if (PlayerController(Controller) != none)
        {
            PlayerController(Controller).SetFOV(DriverPositions[DriverPositionIndex].ViewFOV);
        }
    }

Begin:
    HandleTransition();
    Sleep(0.2);
}

// Modified so mesh rotation is matched in all net modes, not just standalone as in the RO original (not sure why they did that)
// Also to remove playing BeginningIdleAnim as that now gets done for all net modes in DrivingStatusChanged()
simulated state LeavingVehicle
{
    simulated function HandleExit()
    {
        SwitchMesh(-1); // -1 signifies switch to default external mesh
    }
}

// New function, checked by Fire() so we prevent firing while moving between view points or when on periscope or binoculars
function bool CanFire()
{
    return (!IsInState('ViewTransition') && DriverPositionIndex != PeriscopePositionIndex && DriverPositionIndex != BinocPositionIndex) || ROPlayer(Controller) == none;
}

// Modified to use CanFire() & to skip over obsolete RO functionality in ROTankCannonPawn & optimise what remains
function Fire(optional float F)
{
    if (!CanFire())
    {
        return;
    }

    if (Cannon != none)
    {
        if (Cannon.CannonReloadState != CR_ReadyToFire || !Cannon.bClientCanFireCannon)
        {
            if (Cannon.CannonReloadState == CR_Waiting && ROPlayer(Controller) != none && ROPlayer(Controller).bManualTankShellReloading)
            {
                Cannon.ServerManualReload();
            }

            return;
        }
    }

    super(VehicleWeaponPawn).Fire(F);
}

// Modified to use CanFire() & to skip over obsolete RO functionality in ROTankCannonPawn
function AltFire(optional float F)
{
    if (!CanFire())
    {
        return;
    }

    super(VehicleWeaponPawn).AltFire(F);
}

// Modified to add clientside checks before sending the function call to the server
simulated function SwitchWeapon(byte F)
{
    local ROVehicleWeaponPawn WeaponPawn;
    local bool                bMustBeTankerToSwitch;
    local byte                ChosenWeaponPawnIndex;

    if (VehicleBase == none)
    {
        return;
    }

    // Trying to switch to driver position
    if (F == 1)
    {
        // Stop call to server as there is already a human driver
        if (VehicleBase.Driver != none && VehicleBase.Driver.IsHumanControlled())
        {
            return;
        }

        if (VehicleBase.bMustBeTankCommander)
        {
            bMustBeTankerToSwitch = true;
        }
    }
    // Trying to switch to non-driver position
    else
    {
        ChosenWeaponPawnIndex = F - 2;

        // Stop call to server if player has selected an invalid weapon position or the current position
        // Note that if player presses 0, which is invalid choice, the byte index will end up as 254 & so will still fail this test (which is what we want)
        if (ChosenWeaponPawnIndex >= VehicleBase.PassengerWeapons.Length || ChosenWeaponPawnIndex == PositionInArray)
        {
            return;
        }

        // Stop call to server if player selected a rider position but is buttoned up (no 'teleporting' outside to external rider position)
        if (StopExitToRiderPosition(ChosenWeaponPawnIndex))
        {
            return;
        }

        // Get weapon pawn
        if (ChosenWeaponPawnIndex < VehicleBase.WeaponPawns.Length)
        {
            WeaponPawn = ROVehicleWeaponPawn(VehicleBase.WeaponPawns[ChosenWeaponPawnIndex]);
        }

        if (WeaponPawn != none)
        {
            // Stop call to server as weapon position already has a human player
            if (WeaponPawn.Driver != none && WeaponPawn.Driver.IsHumanControlled())
            {
                return;
            }

            if (WeaponPawn.bMustBeTankCrew)
            {
                bMustBeTankerToSwitch = true;
            }
        }
        // Stop call to server if weapon pawn doesn't exist, UNLESS PassengerWeapons array lists it as a rider position
        // This is because our new system means rider pawns won't exist on clients unless occupied, so we have to allow this switch through to server
        else if (class<ROPassengerPawn>(VehicleBase.PassengerWeapons[ChosenWeaponPawnIndex].WeaponPawnClass) == none)
        {
            return;
        }
    }

    // Stop call to server if player has selected a tank crew role but isn't a tanker
    if (bMustBeTankerToSwitch && (Controller == none || ROPlayerReplicationInfo(Controller.PlayerReplicationInfo) == none ||
        ROPlayerReplicationInfo(Controller.PlayerReplicationInfo).RoleInfo == none || !ROPlayerReplicationInfo(Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCrew))
    {
        DenyEntry(self, 0); // not qualified to operate vehicle

        return;
    }

    ServerChangeDriverPosition(F);
}

// Modified to prevent 'teleporting' outside to external rider position while buttoned up inside vehicle
function ServerChangeDriverPosition(byte F)
{
    if (StopExitToRiderPosition(F - 2)) // driver (1) becomes -1, which for byte becomes 255
    {
        return;
    }

    super.ServerChangeDriverPosition(F);
}

// New function to check if player can exit, displaying an "unbutton hatch" message if he can't (just saves repeating code in different functions)
simulated function bool CanExit()
{
    if (DriverPositionIndex < UnbuttonedPositionIndex || (IsInState('ViewTransition') && DriverPositionIndex == UnbuttonedPositionIndex))
    {
        ReceiveLocalizedMessage(class'DH_VehicleMessage', 4); // must unbutton the hatch

        return false;
    }

    return true;
}

// New function to check if player is trying to 'teleport' outside to external rider position while buttoned up (just saves repeating code in different functions)
simulated function bool StopExitToRiderPosition(byte ChosenWeaponPawnIndex)
{
    local DH_ROTreadCraft TreadCraft;

    TreadCraft = DH_ROTreadCraft(VehicleBase);

    return TreadCraft != none && TreadCraft.bMustUnbuttonToSwitchToRider && TreadCraft.bAllowRiders &&
        ChosenWeaponPawnIndex >= TreadCraft.FirstRiderPositionIndex && ChosenWeaponPawnIndex < TreadCraft.PassengerWeapons.Length && !CanExit();
}

// New function to handle switching between external & internal mesh, including copying cannon's aimed direction to new mesh (just saves code repetition)
simulated function SwitchMesh(int PositionIndex)
{
    local mesh    NewMesh;
    local rotator TurretYaw, TurretPitch;

    if ((Role == ROLE_AutonomousProxy || Level.NetMode == NM_Standalone || Level.NetMode == NM_ListenServer) && Gun != none)
    {
        // If switching to a valid driver position, get its PositionMesh
        if (PositionIndex >= 0 && PositionIndex < DriverPositions.Length)
        {
            if (DriverPositions[PositionIndex].PositionMesh != none)
            {
                NewMesh = DriverPositions[PositionIndex].PositionMesh;
            }
        }
        // Else switch to default external mesh (pass PositionIndex of -1 to signify this, as it's an invalid position)
        else
        {
            NewMesh = Gun.default.Mesh;
        }

        // Only switch mesh if we actually have a different new mesh
        if (NewMesh != Gun.Mesh && NewMesh != none)
        {
            if (bCustomAiming)
            {
                // Save old mesh rotation
                TurretYaw.Yaw = VehicleBase.Rotation.Yaw - CustomAim.Yaw;
                TurretPitch.Pitch = VehicleBase.Rotation.Pitch - CustomAim.Pitch;

                // Switch to the new mesh
                Gun.LinkMesh(NewMesh);

                // Now make the new mesh you swap to have the same rotation as the old one
                Gun.SetBoneRotation(Gun.YawBone, TurretYaw);
                Gun.SetBoneRotation(Gun.PitchBone, TurretPitch);
            }
            else
            {
                Gun.LinkMesh(NewMesh);
            }
        }
    }
}

// New function to match rotation to cannon's current aim, either relative or independent to vehicle rotation
simulated function MatchRotationToGunAim()
{
    local rotator NewRotation;

    if (Gun != none)
    {
        if (bPCRelativeFPRotation)
        {
            NewRotation = Gun.CurrentAim;
        }
        else
        {
            NewRotation = rotator(vector(Gun.CurrentAim) >> Gun.Rotation); // note Gun.Rotation is effectively same as vehicle base's rotation
        }

        NewRotation.Pitch = LimitPitch(NewRotation.Pitch);

        SetRotation(NewRotation); // note owning net client will update rotation back to server
    }
}

// Modified so if PC's rotation was relative to vehicle (bPCRelativeFPRotation), it gets set to the correct non-relative rotation on exit
// Doing this in a more obvious way here avoids the previous workaround in ClientKDriverLeave, which matched the cannon pawn's rotation to the vehicle
simulated function FixPCRotation(PlayerController PC)
{
    PC.SetRotation(rotator(vector(PC.Rotation) >> Gun.Rotation)); // was >> Rotation, i.e. cannon pawn's rotation (note Gun.Rotation is effectively same as vehicle base's rotation)
}

// Re-stated here just to make into simulated functions, so modified LeanLeft & LeanRight exec functions in DHPlayer can call this on the client as a pre-check
simulated function IncrementRange()
{
    if (Gun != none)
    {
        Gun.IncrementRange();
    }
}

simulated function DecrementRange()
{
    if (Gun != none)
    {
        Gun.DecrementRange();
    }
}

// Modified to use new ResupplyAmmo() in the VehicleWeapon classes, instead of GiveInitialAmmo()
function bool ResupplyAmmo()
{
    return Cannon != none && Cannon.ResupplyAmmo();
}

// New function, used by HUD to show coaxial MG reload progress, like the cannon reload
function float GetAltAmmoReloadState()
{
    local float ProportionOfReloadRemaining;

    if (Gun == none)
    {
        return 1.0;
    }
    else if (Gun.FireCountdown <= Gun.AltFireInterval)
    {
        return 0.0;
    }
    else
    {
        if (Cannon == none)
        {
            return 1.0;
        }

        ProportionOfReloadRemaining = Gun.FireCountdown / GetSoundDuration(Cannon.ReloadSound);

        if (ProportionOfReloadRemaining >= 0.75)
        {
            return 1.0;
        }
        else if (ProportionOfReloadRemaining >= 0.5)
        {
            return 0.65;
        }
        else if (ProportionOfReloadRemaining >= 0.25)
        {
            return 0.45;
        }
        else
        {
            return 0.25;
        }
    }
}

// Matt: added as when player is in a vehicle, the HUD keybinds to GrowHUD & ShrinkHUD will now call these same named functions in the vehicle classes
// When player is in a vehicle, these functions do nothing to the HUD, but they can be used to add useful vehicle functionality in subclasses, especially as keys are -/+ by default
simulated function GrowHUD();
simulated function ShrinkHUD();

// Matt: modified to switch to external mesh & default FOV for behind view
simulated function POVChanged(PlayerController PC, bool bBehindViewChanged)
{
    local int i;

    if (PC.bBehindView)
    {
        if (bBehindViewChanged)
        {
            if (bPCRelativeFPRotation)
            {
                PC.SetRotation(rotator(vector(PC.Rotation) >> Gun.Rotation));
            }

            if (bMultiPosition)
            {
                for (i = 0; i < DriverPositions.Length; ++i)
                {
                    DriverPositions[i].PositionMesh = Gun.default.Mesh;
                    DriverPositions[i].ViewFOV = PC.DefaultFOV;
                    DriverPositions[i].ViewPitchUpLimit = 65535;
                    DriverPositions[i].ViewPitchDownLimit = 1;
                }

                SwitchMesh(DriverPositionIndex);

                PC.SetFOV(DriverPositions[DriverPositionIndex].ViewFOV);
            }
            else
            {
                PC.SetFOV(PC.DefaultFOV);
                Gun.PitchUpLimit = 65535;
                Gun.PitchDownLimit = 1;
            }

            Gun.bLimitYaw = false;
        }

        bOwnerNoSee = false;

        if (Driver != none)
        {
            Driver.bOwnerNoSee = !bDrawDriverInTP;
        }

        if (PC == Controller) // no overlays for spectators
        {
            ActivateOverlay(false);
        }
    }
    else
    {
        if (bPCRelativeFPRotation)
        {
            PC.SetRotation(rotator(vector(PC.Rotation) << Gun.Rotation));
        }

        if (bBehindViewChanged)
        {
            if (bMultiPosition)
            {
                for (i = 0; i < DriverPositions.Length; ++i)
                {
                    DriverPositions[i].PositionMesh = default.DriverPositions[i].PositionMesh;
                    DriverPositions[i].ViewFOV = default.DriverPositions[i].ViewFOV;
                    DriverPositions[i].ViewPitchUpLimit = default.DriverPositions[i].ViewPitchUpLimit;
                    DriverPositions[i].ViewPitchDownLimit = default.DriverPositions[i].ViewPitchDownLimit;
                }

                SwitchMesh(DriverPositionIndex);

                PC.SetFOV(DriverPositions[DriverPositionIndex].ViewFOV);
                FPCamPos = DriverPositions[DriverPositionIndex].ViewLocation;
            }
            else
            {
                PC.SetFOV(WeaponFOV);
                Gun.PitchUpLimit = Gun.default.PitchUpLimit;
                Gun.PitchDownLimit = Gun.default.PitchDownLimit;
            }

            Gun.bLimitYaw = Gun.default.bLimitYaw;
        }

        bOwnerNoSee = !bDrawMeshInFP;

        if (Driver != none)
        {
            Driver.bOwnerNoSee = Driver.default.bOwnerNoSee;
        }

        if (bDriving && PC == Controller)
        {
            ActivateOverlay(true);
        }
    }
}

// Matt: toggles between external & internal meshes (mostly useful with behind view if want to see internal mesh)
exec function ToggleMesh()
{
    local int i;

    if ((Level.NetMode == NM_Standalone || class'DH_LevelInfo'.static.DHDebugMode()) && bMultiPosition)
    {
        if (Gun.Mesh == default.DriverPositions[DriverPositionIndex].PositionMesh)
        {
            for (i = 0; i < DriverPositions.Length; ++i)
            {
                DriverPositions[i].PositionMesh = Gun.default.Mesh;
            }
        }
        else
        {
            for (i = 0; i < DriverPositions.Length; ++i)
            {
                DriverPositions[i].PositionMesh = default.DriverPositions[i].PositionMesh;
            }
        }

        SwitchMesh(DriverPositionIndex);
    }
}

// Matt: DH version but keeping it just to view limits & nothing to do with behind view (which is handled by exec functions BehindView & ToggleBehindView)
exec function ToggleViewLimit()
{
    local int i;

    if (class'DH_LevelInfo'.static.DHDebugMode() && Gun != none) // removed requirement to be in single player mode, as valid in multi-player if in DHDebugMode
    {
        if (Gun.bLimitYaw == Gun.default.bLimitYaw && Gun.PitchUpLimit == Gun.default.PitchUpLimit && Gun.PitchDownLimit == Gun.default.PitchDownLimit)
        {
            Gun.bLimitYaw = false;
            Gun.PitchUpLimit = 65535;
            Gun.PitchDownLimit = 1;

            for (i = 0; i < DriverPositions.Length; ++i)
            {
                DriverPositions[i].ViewPitchUpLimit = 65535;
                DriverPositions[i].ViewPitchDownLimit = 1;
            }
        }
        else
        {
            Gun.bLimitYaw = Gun.default.bLimitYaw;
            Gun.PitchUpLimit = Gun.default.PitchUpLimit;
            Gun.PitchDownLimit = Gun.default.PitchDownLimit;

            for (i = 0; i < DriverPositions.Length; ++i)
            {
                DriverPositions[i].ViewPitchUpLimit = default.DriverPositions[i].ViewPitchUpLimit;
                DriverPositions[i].ViewPitchDownLimit = default.DriverPositions[i].ViewPitchDownLimit;
            }
        }
    }
}

// Allows 'Driver' (commander) debugging to be toggled for all cannon pawns
exec function ToggleDriverDebug()
{
    if (class'DH_LevelInfo'.static.DHDebugMode())
    {
        ServerToggleDriverDebug();
    }
}

function ServerToggleDriverDebug()
{
    if (class'DH_LevelInfo'.static.DHDebugMode())
    {
        class'DH_ROTankCannon'.default.bDriverDebugging = !class'DH_ROTankCannon'.default.bDriverDebugging;
        Log("DH_ROTankCannon.bDriverDebugging =" @ class'DH_ROTankCannon'.default.bDriverDebugging);
    }
}

// Allows debugging exit positions to be toggled for all cannon pawns
exec function ToggleDebugExits()
{
    if (class'DH_LevelInfo'.static.DHDebugMode())
    {
        ServerToggleDebugExits();
    }
}

function ServerToggleDebugExits()
{
    if (class'DH_LevelInfo'.static.DHDebugMode())
    {
        class'DH_ROTankCannonPawn'.default.bDebugExitPositions = !class'DH_ROTankCannonPawn'.default.bDebugExitPositions;
        Log("DH_ROTankCannonPawn.bDebugExitPositions =" @ class'DH_ROTankCannonPawn'.default.bDebugExitPositions);
    }
}

defaultproperties
{
    bShowRangeText=true
    GunsightPositions=1
    UnbuttonedPositionIndex=2
    ManualRotateSound=sound'Vehicle_Weapons.Turret.manual_turret_traverse2'
    ManualPitchSound=sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    ManualRotateAndPitchSound=sound'Vehicle_Weapons.Turret.manual_turret_traverse'
    ManualMinRotateThreshold=0.25
    ManualMaxRotateThreshold=2.5
    PoweredMinRotateThreshold=0.15
    PoweredMaxRotateThreshold=1.75
    MaxRotateThreshold=1.5
    bPCRelativeFPRotation=true
    bFPNoZFromCameraPitch=true
    bDesiredBehindView=false
    PeriscopePositionIndex=-1
    AltAmmoReloadTexture=texture'DH_InterfaceArt_tex.Tank_Hud.MG42_ammo_reload'
}
