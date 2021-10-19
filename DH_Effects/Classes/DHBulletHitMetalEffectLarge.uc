//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2021
//==============================================================================

class DHBulletHitMetalEffectLarge extends emitter;

var texture SparkGroup[4];

//particles: 34

simulated function PostBeginPlay()
{
    Emitters[4].Texture = SparkGroup[Rand(4)];
    Super.PostBeginPlay();
}

defaultproperties
{
    SparkGroup(0)=Texture'DH_FX_Tex.Sparks.sparks01'
    SparkGroup(1)=Texture'DH_FX_Tex.Sparks.sparks02'
    SparkGroup(2)=Texture'DH_FX_Tex.Sparks.sparks03'
    SparkGroup(3)=Texture'DH_FX_Tex.Sparks.sparks04'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="flash"
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=6.000000,Max=18.000000))
        InitialParticlesPerSecond=500.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'Effects_Tex.Weapons.muzzle_4frame3rd'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        UseVelocityScale=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.3
        MaxParticles=4
        Name="light_smoke"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.150000,Max=0.150000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=25.000000,Max=45.000000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'Effects_Tex.BulletHits.snowfinal2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=50.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
        VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
        VelocityScale(1)=(RelativeTime=0.475000,RelativeVelocity=(X=0.100000,Y=0.200000,Z=0.200000))
        VelocityScale(2)=(RelativeTime=1.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseCollision=True
        UseMaxCollisions=True
        UseDirectionAs=PTDU_UpAndNormal
        ProjectionNormal=(X=1.000000,Y=0.500000)
        UseColorScale=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(X=100.000000,Y=10.000000,Z=-150.000000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
        ColorScaleRepeats=4.0
        FadeOutStartTime=0.300000
        MaxParticles=15
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Max=20.000000)
        SpinsPerSecondRange=(X=(Min=0.500000,Max=4.000000))
        StartSpinRange=(X=(Min=-0.500000,Max=1.000000))
        //StartSizeRange=(X=(Min=1.500000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=0.1)
        SizeScale(1)=(RelativeTime=0.140000,RelativeSize=3.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=0.350000,Max=0.500000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'Effects_Tex.Smoke.Sparks'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.350000,Max=0.750000)
        StartVelocityRange=(X=(Min=100.000000,Max=200.000000),Y=(Min=-75.000000,Max=85.000000),Z=(Min=-85.000000,Max=75.000000))
        StartVelocityRadialRange=(Min=2.000000,Max=20.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SparkEmitter Name=SparkEmitter1
        LineSegmentsRange=(Min=0.000000,Max=0.000000)
        TimeBetweenSegmentsRange=(Min=0.030000,Max=0.075000)
        FadeOut=True
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.200000
        MaxParticles=8
        UseRotationFrom=PTRS_Actor
        StartSizeRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000),Z=(Min=1.000000,Max=3.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'Effects_Tex.BulletHits.sparkfinal2'
        LifetimeRange=(Min=0.150000,Max=0.250000)
        StartVelocityRange=(X=(Min=150.000000,Max=200.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
    End Object
    Emitters(3)=SparkEmitter'SparkEmitter1'

    Begin Object Class=BeamEmitter Name=BeamEmitter4
        BeamDistanceRange=(Min=25.000000,Max=45.000000)
        DetermineEndPointBy=PTEP_Distance
        RotatingSheets=1
        UseColorScale=false
        RespawnDeadParticles=False
        AutoDestroy=True
        AutomaticInitialSpawning=False
        //StartLocationOffset=(X=-4.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=4
        Name="SparkGroups"
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=15.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_Brighten
        LifetimeRange=(Min=0.100,Max=0.150000)
        StartVelocityRange=(X=(Min=300.000000,Max=600.000000),Y=(Min=-100.000000,Max=125.000000),Z=(Min=-125.000000,Max=100.000000))
    End Object
    Emitters(4)=BeamEmitter'BeamEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter25
        FadeOut=true
        RespawnDeadParticles=False
        //SpinParticles=True
        UniformSize=True
        UseColorScale=true
        AutomaticInitialSpawning=False
        UseSizeScale=True
        ColorScale(0)=(Color=(B=147,G=147,R=147,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=147,G=147,R=147,A=255))
        Opacity=0.75
        MaxParticles=2
        Name="fabric_smoke"
        UseRotationFrom=PTRS_Actor
        //SpinsPerSecondRange=(X=(Min=0.15000,Max=0.2500000))
        //StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.00000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=45.00000,Max=65.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'DH_FX_Tex.dust.dustpuff01'
        LifetimeRange=(Min=0.25,Max=0.55)
        StartVelocityRange=(X=(Min=150.000000,Max=250.000000),Y=(Min=-35.000000,Max=45.000000),Z=(Min=-45.000000,Max=35.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter25'

    Autodestroy=true
    bnodelete=false
}
