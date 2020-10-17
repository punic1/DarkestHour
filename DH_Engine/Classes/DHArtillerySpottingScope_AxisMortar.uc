//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHArtillerySpottingScope_AxisMortar extends DHArtillerySpottingScope
    abstract;

defaultproperties
{
    SpottingScopeOverlay=Texture'DH_VehicleOptics_tex.German.RblF16_artillery_sight'   // TODO: REPLACE

    RangeTable(0)=(Range=50,Pitch=86.5)
    RangeTable(1)=(Range=75,Pitch=85.0)
    RangeTable(2)=(Range=100,Pitch=83.0)
    RangeTable(3)=(Range=125,Pitch=81.0)
    RangeTable(4)=(Range=150,Pitch=79.5)
    RangeTable(5)=(Range=175,Pitch=77.5)
    RangeTable(6)=(Range=200,Pitch=75.5)
    RangeTable(7)=(Range=225,Pitch=73.5)
    RangeTable(8)=(Range=250,Pitch=71.0)
    RangeTable(9)=(Range=275,Pitch=69.0)
    RangeTable(10)=(Range=300,Pitch=66.5)
    RangeTable(11)=(Range=325,Pitch=63.5)
    RangeTable(12)=(Range=350,Pitch=60.5)
    RangeTable(13)=(Range=375,Pitch=57.0)
    RangeTable(14)=(Range=400,Pitch=51.0)

    YawScaleStep=5.0
    PitchScaleStep=0.5
    PitchDecimalsTable=1
    PitchStepMajor=10.0
    PitchStepMinor=2.0
}