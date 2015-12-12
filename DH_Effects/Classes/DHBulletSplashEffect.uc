//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DHBulletSplashEffect extends Emitter; // slight changes from 'ROBulletHitWaterEffect', mostly to add splash sound to SpriteEmitter1
                                            // (could easily extend ROBulletHitWaterEffect, without having to restate all the other emitters)
defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.0,Z=0.0)
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        DampRotation=true
        UseSizeScale=true
        UseRegularSizeScale=false
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseSubdivisionScale=true
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        StartLocationOffset=(X=6.0) // added
        Name="SpriteEmitter73"
        UseRotationFrom=PTRS_Actor
        SpinCCWorCW=(X=0.0,Y=0.0,Z=0.0)
        SpinsPerSecondRange=(X=(Min=-0.1,Max=0.1))
        SizeScale(0)=(RelativeSize=1.0)
        SizeScale(1)=(RelativeTime=0.5,RelativeSize=2.5)
        SizeScale(2)=(RelativeTime=1.0,RelativeSize=4.0)
        StartSizeRange=(X=(Min=15.0,Max=20.0),Y=(Min=15.0,Max=20.0),Z=(Min=15.0,Max=20.0))
        InitialParticlesPerSecond=100.0
        DrawStyle=PTDS_Brighten
        Texture=texture'Effects_Tex.BulletHits.waterring_2frame'
        TextureUSubdivisions=2
        TextureVSubdivisions=1
        SubdivisionScale(0)=0.5
        LifetimeRange=(Min=1.0,Max=1.5)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseRandomSubdivision=true
        UseVelocityScale=true
        Acceleration=(Z=-600.0)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.5
        MaxParticles=3
        Name="SpriteEmitter74"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.5,Max=0.5))
        SizeScale(0)=(RelativeSize=2.0)
        SizeScale(1)=(RelativeTime=1.0,RelativeSize=5.0)
        StartSizeRange=(X=(Min=5.5,Max=7.0))
        InitialParticlesPerSecond=500.0
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.BulletHits.watersplashcloud'
        LifetimeRange=(Min=1.5,Max=1.5)
        StartVelocityRange=(X=(Min=150.0,Max=250.0),Y=(Min=-10.0,Max=10.0),Z=(Min=-10.0,Max=10.0))
        VelocityScale(0)=(RelativeVelocity=(X=1.0,Y=1.0,Z=1.0))
        VelocityScale(1)=(RelativeTime=0.205,RelativeVelocity=(X=0.1,Y=0.5,Z=0.5))
        VelocityScale(2)=(RelativeTime=1.0,RelativeVelocity=(X=0.15,Y=0.1,Z=0.1))
        // Sounds are added:
        Sounds(0)=(Sound=SoundGroup'ProjectileSounds.Bullets.Impact_Water',Radius=(Min=128.0,Max=256.0),Pitch=(Min=1.0,Max=1.0),Volume=(Min=0.64,Max=0.8),Probability=(Min=1.0,Max=1.0))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=0.75,Max=0.75)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        UniformSize=true
        AutomaticInitialSpawning=false
        UseRandomSubdivision=true
        Acceleration=(Z=-500.0)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.5
        FadeOutStartTime=0.4
        MaxParticles=35
        Name="SpriteEmitter75"
        UseRotationFrom=PTRS_Actor
        StartSizeRange=(X=(Min=0.5,Max=0.75))
        InitialParticlesPerSecond=300.0
        DrawStyle=PTDS_Brighten
        Texture=texture'Effects_Tex.Smoke.Sparks'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.0,Max=1.0)
        StartVelocityRange=(X=(Min=100.0,Max=200.0),Y=(Min=-75.0,Max=75.0),Z=(Min=-75.0,Max=75.0))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseRandomSubdivision=true
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="SpriteEmitter76"
        UseRotationFrom=PTRS_Actor
        SizeScale(1)=(RelativeTime=1.0,RelativeSize=2.0)
        StartSizeRange=(X=(Min=15.0,Max=20.0))
        InitialParticlesPerSecond=100.0
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.BulletHits.watersplatter2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.5,Max=0.5)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'

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
        UseRandomSubdivision=true
        UseVelocityScale=true
        Acceleration=(Z=-700.0)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.5
        MaxParticles=3
        Name="SpriteEmitter77"
        StartLocationRange=(X=(Min=-10.0,Max=10.0))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.5,Max=0.5))
        SizeScale(0)=(RelativeSize=2.0)
        SizeScale(1)=(RelativeTime=1.0,RelativeSize=3.0)
        StartSizeRange=(X=(Min=3.0,Max=5.0))
        InitialParticlesPerSecond=500.0
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.BulletHits.watersplashcloud'
        LifetimeRange=(Min=1.5,Max=1.5)
        StartVelocityRange=(X=(Min=250.0,Max=300.0),Y=(Min=-10.0,Max=10.0),Z=(Min=-10.0,Max=10.0))
        VelocityScale(0)=(RelativeVelocity=(X=1.0,Y=1.0,Z=1.0))
        VelocityScale(1)=(RelativeTime=0.205,RelativeVelocity=(X=0.1,Y=0.5,Z=0.5))
        VelocityScale(2)=(RelativeTime=1.0,RelativeVelocity=(X=0.15,Y=0.1,Z=0.1))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseRandomSubdivision=true
        UseVelocityScale=true
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=3
        Name="SpriteEmitter78"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.15,Max=0.15))
        SizeScale(0)=(RelativeSize=0.5)
        SizeScale(1)=(RelativeTime=1.0,RelativeSize=1.0)
        StartSizeRange=(X=(Min=15.0,Max=25.0))
        InitialParticlesPerSecond=100.0
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.BulletHits.watersplatter2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.75,Max=0.75)
        StartVelocityRange=(X=(Min=50.0,Max=100.0),Y=(Min=-10.0,Max=10.0),Z=(Min=-10.0,Max=10.0))
        VelocityScale(0)=(RelativeVelocity=(X=1.0,Y=1.0,Z=1.0))
        VelocityScale(1)=(RelativeTime=0.475,RelativeVelocity=(X=0.1,Y=0.2,Z=0.2))
        VelocityScale(2)=(RelativeTime=1.0)
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=true
        FadeIn=true
        RespawnDeadParticles=false
        SpinParticles=true
        UseSizeScale=true
        UseRegularSizeScale=false
        UniformSize=true
        AutomaticInitialSpawning=false
        BlendBetweenSubdivisions=true
        UseRandomSubdivision=true
        UseVelocityScale=true
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.0,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=3
        Name="SpriteEmitter79"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.05,Max=0.05))
        SizeScale(0)=(RelativeSize=0.5)
        SizeScale(1)=(RelativeTime=1.0,RelativeSize=1.0)
        StartSizeRange=(X=(Min=10.0,Max=20.0))
        InitialParticlesPerSecond=100.0
        DrawStyle=PTDS_AlphaBlend
        Texture=texture'Effects_Tex.BulletHits.watersplatter2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.75,Max=0.75)
        StartVelocityRange=(X=(Min=50.0,Max=200.0),Y=(Min=-10.0,Max=10.0),Z=(Min=-10.0,Max=10.0))
        VelocityScale(0)=(RelativeVelocity=(X=1.0,Y=1.0,Z=1.0))
        VelocityScale(1)=(RelativeTime=0.475,RelativeVelocity=(X=0.1,Y=0.2,Z=0.2))
        VelocityScale(2)=(RelativeTime=1.0)
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter6'

    AutoDestroy=true
    bNoDelete=false
    bHighDetail=true // added
}
