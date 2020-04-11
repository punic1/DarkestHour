//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_SU76CannonPawn extends DHSovietCannonPawn;

//to do: periscope and/or DT machinegun

defaultproperties
{
    GunClass=class'DH_Vehicles.DH_SU76Cannon'
    DriverPositions(0)=(ViewLocation=(X=85,Y=-10.0,Z=11.0),ViewFOV=34,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=6000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=3000,ViewNegativeYawLimit=-3000,bDrawOverlays=true,bExposed=true)
    DriverPositions(1)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=VSU76_com_close,TransitionUpAnim=com_open,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=false,bExposed=true)
    DriverPositions(2)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=85,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=VSU76_com_open,TransitionDownAnim=com_close,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=false,bExposed=true)
    DriverPositions(3)=(ViewLocation=(X=0,Y=0,Z=0),ViewFOV=20,PositionMesh=Mesh'allies_su76_anm.SU76_turret_int',DriverTransitionAnim=none,ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=65536,ViewNegativeYawLimit=-65536,bDrawOverlays=True,bExposed=true)

    AmmoShellTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell'

    UnbuttonedPositionIndex=2
    BinocPositionIndex=3

    bManualTraverseOnly=true

    DriveAnim=VSU76_com_idle_close
    bLockCameraDuringTransition=false

    bHasFireImpulse=True
    FireImpulse=(X=-70000,Y=0.0,Z=0.0)

    bHasAltFire=false

    DestroyedGunsightOverlay=Texture'DH_VehicleOpticsDestroyed_tex.German.PZ4_sight_destroyed' // matches size of gunsight

    AmmoShellReloadTexture=Texture'InterfaceArt_tex.Tank_Hud.T3476_SU76_Kv1shell_reload'
    ManualRotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
    ManualRotateAndPitchSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'

    GunsightOverlay=Texture'DH_VehicleOptics_tex.Soviet.PG1_sight_background'
    GunsightSize=0.441 // 10.5 degrees visible FOV at 3.7x magnification (PG1 sight)

}
