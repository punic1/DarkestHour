//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_VehicleDestroyedEmitter extends Emitter;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        Acceleration=(X=50.000000,Y=20.000000,Z=50.000000)
        ColorScale(0)=(Color=(B=47,G=100,R=149,A=255))
        ColorScale(1)=(RelativeTime=0.271429,Color=(A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        FadeOutStartTime=4.000000
        FadeInEndTime=0.320000
        MaxParticles=100
        StartLocationOffset=(Z=150.000000)
        StartLocationRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000))
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.400000)
        StartSizeRange=(X=(Min=75.000000),Y=(Min=75.000000),Z=(Min=75.000000))
        ParticlesPerSecond=3.000000
        InitialParticlesPerSecond=3.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'SpecialEffects.Smoke.LSmoke2'
        LifetimeRange=(Min=14.000000,Max=14.000000)
        StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=25.000000,Max=150.000000))
        VelocityLossRange=(X=(Min=0.250000,Max=1.000000),Y=(Min=0.250000,Max=1.000000),Z=(Min=0.250000,Max=1.000000))
    End Object
    Emitters(0)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter0'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseRandomSubdivision=true
        UseVelocityScale=true
        Acceleration=(Z=150.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=0.250000,Color=(B=100,G=177,R=230,A=255))
        ColorScale(2)=(RelativeTime=0.750000,Color=(B=5,R=230,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.600000
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=150.000000,Max=200.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_Brighten
        Texture=texture'Effects_Tex.explosions.fire_16frame'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
        VelocityScale(0)=(RelativeTime=0.100000,RelativeVelocity=(X=0.100000,Y=0.100000,Z=0.100000))
        VelocityScale(1)=(RelativeTime=0.500000,RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
        VelocityScale(2)=(RelativeTime=1.000000)
    End Object
    Emitters(1)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter1'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        TriggerDisabled=false
        ResetOnTrigger=true
        ColorScale(0)=(Color=(B=82,G=82,R=82,A=255))
        ColorScale(1)=(RelativeTime=0.500000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.750000
        FadeOutStartTime=0.500000
        FadeInEndTime=0.200000
        MaxParticles=5
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=300.000000))
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=0.140000,RelativeSize=6.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=14.000000)
        StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=60.000000),Z=(Min=45.000000,Max=50.000000))
        InitialParticlesPerSecond=500.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.explosions.LSmoke3'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000)
        StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=50.000000,Max=50.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=3.000000,Max=3.000000))
    End Object
    Emitters(2)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter2'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseColorScale=true
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        TriggerDisabled=false
        ResetOnTrigger=true
        Acceleration=(X=100.000000,Y=100.000000)
        ColorScale(0)=(Color=(B=35,G=35,R=35,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        FadeOutStartTime=1.020000
        FadeInEndTime=0.510000
        StartLocationOffset=(Z=150.000000)
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Max=120.000000),Y=(Max=120.000000),Z=(Min=45.000000,Max=50.000000))
        InitialParticlesPerSecond=500.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.explosions.DSmoke_2'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=1000.000000,Max=1500.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
    End Object
    Emitters(3)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter3'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        Acceleration=(Z=50.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.200000
        FadeInEndTime=0.050000
        MaxParticles=2
        StartLocationOffset=(Z=250.000000)
        SpinCCWorCW=(X=0.000000)
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
        InitialParticlesPerSecond=30.000000
        DrawStyle=PTDS_Brighten
        Texture=texture'Effects_Tex.explosions.impact_2frame'
        TextureUSubdivisions=2
        TextureVSubdivisions=1
        LifetimeRange=(Min=0.500000,Max=0.500000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(Z=(Min=10.000000,Max=10.000000))
    End Object
    Emitters(4)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter4'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        Acceleration=(Z=50.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.200000
        FadeInEndTime=0.050000
        MaxParticles=2
        StartLocationOffset=(Z=50.000000)
        SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
        InitialParticlesPerSecond=30.000000
        DrawStyle=PTDS_Brighten
        Texture=texture'Effects_Tex.explosions.impact_2frame'
        TextureUSubdivisions=2
        TextureVSubdivisions=1
        LifetimeRange=(Min=0.750000,Max=0.750000)
        StartVelocityRange=(Z=(Min=10.000000,Max=10.000000))
    End Object
    Emitters(5)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter5'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        ProjectionNormal=(X=200.000000,Y=200.000000)
        UseColorScale=true
        FadeOut=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        UseVelocityScale=true
        Acceleration=(Z=5.000000)
        ColorScale(0)=(Color=(A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=192,R=192))
        FadeOutStartTime=3.480000
        UseRotationFrom=PTRS_Offset
        SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
        SizeScale(0)=(RelativeSize=5.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=10.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=40.000000)
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        InitialParticlesPerSecond=1000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.explosions.DSmoke_2'
        LifetimeRange=(Max=6.000000)
        StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
        VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
        VelocityScale(1)=(RelativeTime=0.100000,RelativeVelocity=(X=0.200000,Y=0.200000,Z=1.000000))
        VelocityScale(2)=(RelativeTime=1.000000)
    End Object
    Emitters(6)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter6'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseColorScale=true
        RespawnDeadParticles=false
        UseRevolution=true
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        Acceleration=(Z=-1200.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.650000
        MaxParticles=12
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
        SizeScale(0)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=2.000000,Max=6.000000),Y=(Min=2.000000,Max=6.000000),Z=(Min=3.000000,Max=5.000000))
        InitialParticlesPerSecond=50.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.explosions.shrapnel3'
        StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=500.000000,Max=1000.000000))
    End Object
    Emitters(7)=SpriteEmitter'DH_Effects.DH_VehicleDestroyedEmitter.SpriteEmitter7'
    AutoDestroy=true
    bNoDelete=false
    bNetTemporary=true
    RemoteRole=ROLE_SimulatedProxy
    LifeSpan=8.000000
    Style=STY_Masked
    bHardAttach=true
    bDirectional=true
}
