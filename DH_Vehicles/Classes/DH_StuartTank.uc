//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_StuartTank extends DH_ROTreadCraft;

#exec OBJ LOAD FILE=..\Animations\DH_Stuart_anm.ukx
#exec OBJ LOAD FILE=..\Textures\DH_VehiclesUS_tex.utx

static function StaticPrecache(LevelInfo L)
{
    super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.ext_vehicles.M5_body_ext');
    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.M5_body_int');
    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.treads.M5_treads');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.ext_vehicles.M5_body_ext');
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.M5_body_int');
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.treads.M5_treads');

    super.UpdatePrecacheMaterials();
}

defaultproperties
{
    LeftTreadIndex=3
    MaxCriticalSpeed=1057.000000
    FireAttachBone="Player_Driver"
    HullFireChance=0.450000
    UFrontArmorFactor=2.900000
    URightArmorFactor=2.900000
    ULeftArmorFactor=2.900000
    URearArmorFactor=2.500000
    UFrontArmorSlope=48.000000
    URearArmorSlope=17.000000
    PointValue=2.000000
    MaxPitchSpeed=150.000000
    TreadVelocityScale=215.000000
    LeftTreadSound=sound'Vehicle_Engines.tracks.track_squeak_L03'
    RightTreadSound=sound'Vehicle_Engines.tracks.track_squeak_R03'
    RumbleSound=sound'DH_AlliedVehicleSounds.stuart.stuart_inside_rumble'
    LeftTrackSoundBone="Track_L"
    RightTrackSoundBone="Track_R"
    RumbleSoundBone="placeholder_int"
    VehicleHudTurret=TexRotator'DH_InterfaceArt_tex.Tank_Hud.Stuart_turret_rot'
    VehicleHudTurretLook=TexRotator'DH_InterfaceArt_tex.Tank_Hud.Stuart_turret_look'
    VehicleHudThreadsPosX(0)=0.370000
    VehicleHudThreadsPosX(1)=0.630000
    VehicleHudThreadsPosY=0.510000
    VehicleHudThreadsScale=0.720000
    LeftWheelBones(0)="Wheel_L_1"
    LeftWheelBones(1)="Wheel_L_2"
    LeftWheelBones(2)="Wheel_L_3"
    LeftWheelBones(3)="Wheel_L_4"
    LeftWheelBones(4)="Wheel_L_5"
    LeftWheelBones(5)="Wheel_L_6"
    LeftWheelBones(6)="Wheel_L_7"
    LeftWheelBones(7)="Wheel_L_8"
    LeftWheelBones(8)="Wheel_L_9"
    RightWheelBones(0)="Wheel_R_1"
    RightWheelBones(1)="Wheel_R_2"
    RightWheelBones(2)="Wheel_R_3"
    RightWheelBones(3)="Wheel_R_4"
    RightWheelBones(4)="Wheel_R_5"
    RightWheelBones(5)="Wheel_R_6"
    RightWheelBones(6)="Wheel_R_7"
    RightWheelBones(7)="Wheel_R_8"
    RightWheelBones(8)="Wheel_R_9"
    WheelRotationScale=2000
    TreadHitMinAngle=1.150000
    FrontLeftAngle=332.000000
    RearLeftAngle=208.000000
    GearRatios(3)=0.650000
    GearRatios(4)=0.750000
    TransRatio=0.130000
    LeftLeverBoneName="lever_L"
    LeftLeverAxis=AXIS_Z
    RightLeverBoneName="lever_R"
    RightLeverAxis=AXIS_Z
    ExhaustEffectClass=class'ROEffects.ExhaustPetrolEffect'
    ExhaustEffectLowClass=class'ROEffects.ExhaustPetrolEffect_simple'
    ExhaustPipes(0)=(ExhaustPosition=(X=-100.000000,Z=45.000000),ExhaustRotation=(Pitch=31000,Yaw=-16384))
    PassengerWeapons(0)=(WeaponPawnClass=class'DH_Vehicles.DH_StuartCannonPawn',WeaponBone="Turret_placement")
    PassengerWeapons(1)=(WeaponPawnClass=class'DH_Vehicles.DH_StuartMountedMGPawn',WeaponBone="Mg_placement")
    PassengerWeapons(2)=(WeaponPawnClass=class'DH_Vehicles.DH_StuartPassengerOne',WeaponBone="body")
    PassengerWeapons(3)=(WeaponPawnClass=class'DH_Vehicles.DH_StuartPassengerTwo',WeaponBone="body")
    PassengerWeapons(4)=(WeaponPawnClass=class'DH_Vehicles.DH_StuartPassengerThree',WeaponBone="body")
    IdleSound=SoundGroup'DH_AlliedVehicleSounds.stuart.stuart_engine_loop'
    StartUpSound=sound'Vehicle_Engines.T60.t60_engine_start'
    ShutDownSound=sound'Vehicle_Engines.T60.t60_engine_stop'
    DestroyedVehicleMesh=StaticMesh'DH_allies_vehicles_stc.M5_Stuart.M5_Stuart_dest1'
    DamagedEffectOffset=(X=-78.500000,Y=20.000000,Z=100.000000)
    VehicleTeam=1
    SteeringScaleFactor=0.750000
    BeginningIdleAnim="driver_hatch_idle_close"
    DriverPositions(0)=(PositionMesh=SkeletalMesh'DH_Stuart_anm.Stuart_body_int',TransitionUpAnim="Overlay_Out",ViewPitchUpLimit=1,ViewPitchDownLimit=65535,ViewPositiveYawLimit=5500,ViewNegativeYawLimit=-5500,ViewFOV=90.000000,bDrawOverlays=true)
    DriverPositions(1)=(PositionMesh=SkeletalMesh'DH_Stuart_anm.Stuart_body_int',TransitionUpAnim="driver_hatch_open",TransitionDownAnim="Overlay_In",DriverTransitionAnim="VPanzer3_driver_idle_open",ViewPitchUpLimit=3000,ViewPitchDownLimit=61922,ViewPositiveYawLimit=8000,ViewNegativeYawLimit=-8000,ViewFOV=90.000000)
    DriverPositions(2)=(PositionMesh=SkeletalMesh'DH_Stuart_anm.Stuart_body_int',TransitionDownAnim="driver_hatch_close",DriverTransitionAnim="VPanzer3_driver_idle_open",ViewPitchUpLimit=10000,ViewPitchDownLimit=62000,ViewPositiveYawLimit=16000,ViewNegativeYawLimit=-16000,bExposed=true,ViewFOV=90.000000)
    VehicleHudImage=texture'DH_InterfaceArt_tex.Tank_Hud.stuart_body'
    VehicleHudOccupantsX(0)=0.430000
    VehicleHudOccupantsX(3)=0.350000
    VehicleHudOccupantsX(4)=0.500000
    VehicleHudOccupantsX(5)=0.650000
    VehicleHudOccupantsY(0)=0.350000
    VehicleHudOccupantsY(2)=0.350000
    VehicleHudOccupantsY(3)=0.720000
    VehicleHudOccupantsY(4)=0.800000
    VehicleHudOccupantsY(5)=0.720000
    VehicleHudEngineX=0.510000
    VehHitpoints(0)=(PointBone="Player_Driver",PointOffset=(Y=1.000000,Z=3.000000),bPenetrationPoint=false)
    VehHitpoints(1)=(PointOffset=(X=-73.000000,Z=10.000000),DamageMultiplier=1.000000)
    VehHitpoints(2)=(PointRadius=20.000000,PointScale=1.000000,PointBone="body",PointOffset=(Z=10.000000),DamageMultiplier=5.000000,HitPointType=HP_AmmoStore)
    VehHitpoints(3)=(PointRadius=10.000000,PointScale=1.000000,PointBone="body",PointOffset=(Y=-45.000000,Z=30.000000),DamageMultiplier=5.000000,HitPointType=HP_AmmoStore)
    VehHitpoints(4)=(PointRadius=10.000000,PointScale=1.000000,PointBone="body",PointOffset=(Y=45.000000,Z=30.000000),DamageMultiplier=5.000000,HitPointType=HP_AmmoStore)
    EngineHealth=200
    DriverAttachmentBone="driver_attachment"
    Begin Object Class=SVehicleWheel Name=LF_Steering
        bPoweredWheel=true
        SteerType=VST_Steered
        BoneName="steer_wheel_LF"
        BoneRollAxis=AXIS_Y
        BoneOffset=(Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(0)=SVehicleWheel'DH_Vehicles.DH_StuartTank.LF_Steering'
    Begin Object Class=SVehicleWheel Name=RF_Steering
        bPoweredWheel=true
        SteerType=VST_Steered
        BoneName="steer_wheel_RF"
        BoneRollAxis=AXIS_Y
        BoneOffset=(Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(1)=SVehicleWheel'DH_Vehicles.DH_StuartTank.RF_Steering'
    Begin Object Class=SVehicleWheel Name=LR_Steering
        bPoweredWheel=true
        SteerType=VST_Inverted
        BoneName="steer_wheel_LR"
        BoneRollAxis=AXIS_Y
        BoneOffset=(X=-50.000000,Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(2)=SVehicleWheel'DH_Vehicles.DH_StuartTank.LR_Steering'
    Begin Object Class=SVehicleWheel Name=RR_Steering
        bPoweredWheel=true
        SteerType=VST_Inverted
        BoneName="steer_wheel_RR"
        BoneRollAxis=AXIS_Y
        BoneOffset=(X=-50.000000,Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(3)=SVehicleWheel'DH_Vehicles.DH_StuartTank.RR_Steering'
    Begin Object Class=SVehicleWheel Name=Left_Drive_Wheel
        bPoweredWheel=true
        BoneName="drive_wheel_L"
        BoneRollAxis=AXIS_Y
        BoneOffset=(X=-20.000000,Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(4)=SVehicleWheel'DH_Vehicles.DH_StuartTank.Left_Drive_Wheel'
    Begin Object Class=SVehicleWheel Name=Right_Drive_Wheel
        bPoweredWheel=true
        BoneName="drive_wheel_R"
        BoneRollAxis=AXIS_Y
        BoneOffset=(X=-20.000000,Z=11.000000)
        WheelRadius=33.000000
    End Object
    Wheels(5)=SVehicleWheel'DH_Vehicles.DH_StuartTank.Right_Drive_Wheel'
    VehicleMass=7.000000
    bFPNoZFromCameraPitch=true
    DrivePos=(X=0.000000,Y=8.000000,Z=0.000000)
    DriveAnim="VPanzer3_driver_idle_close"
    ExitPositions(0)=(X=100.0,Y=-30.0,Z=175.0)  //driver hatch
    ExitPositions(1)=(X=0.0,Y=0.0,Z=225.0)	    //commander hatch
    ExitPositions(2)=(X=100.0,Y=30.0,Z=175.0)	//mg hatch
    ExitPositions(3)=(X=-75.0,Y=-125.0,Z=75.0)	//left
    ExitPositions(4)=(X=-200.0,Y=2.24,Z=75.0)	//rear
    ExitPositions(5)=(X=-75.0,Y=125.0,Z=75.0)	//right
    ExitPositions(6)=(X=200.0,Y=0,Z=75.0)	    //front
    EntryRadius=350.000000
    FPCamPos=(X=0.000000,Y=0.000000,Z=0.000000)
    TPCamDistance=600.000000
    TPCamLookat=(X=-50.000000)
    TPCamWorldOffset=(Z=250.000000)
    DriverDamageMult=1.000000
    VehicleNameString="M5 Stuart"
    MaxDesireability=1.900000
    HUDOverlayOffset=(X=5.000000)
    HUDOverlayFOV=90.000000
    PitchUpLimit=5000
    PitchDownLimit=60000
    HealthMax=375.000000
    Health=375
    Mesh=SkeletalMesh'DH_Stuart_anm.Stuart_body_ext'
    Skins(0)=texture'DH_VehiclesUS_tex.ext_vehicles.M5_body_ext'
    Skins(1)=texture'DH_VehiclesUS_tex.int_vehicles.M5_body_int'
    Skins(2)=texture'DH_VehiclesUS_tex.Treads.M5_treads'
    Skins(3)=texture'DH_VehiclesUS_tex.Treads.M5_treads'
    SoundPitch=32
    SoundRadius=800.000000
    TransientSoundRadius=1500.000000
    CollisionRadius=175.000000
    CollisionHeight=60.000000
    LeftTreadPanDirection=(Pitch=0,Yaw=32768,Roll=16384)
    RightTreadPanDirection=(Pitch=0,Yaw=32768,Roll=16384)
}
