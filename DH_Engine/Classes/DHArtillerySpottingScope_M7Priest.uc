//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHArtillerySpottingScope_M7Priest extends DHArtillerySpottingScope
    abstract;

defaultproperties
{
    // to do: replace with some cool American overlay
    SpottingScopeOverlay=Texture'DH_VehicleOptics_tex.British.BesaMG_sight'

    YawScaleStep=5.0
    PitchScaleStep=5.0

    RangeTable(0)=(Pitch=0,Range=115)
    RangeTable(1)=(Pitch=25,Range=200)
    RangeTable(2)=(Pitch=50,Range=300)
    RangeTable(3)=(Pitch=75,Range=400)
    RangeTable(4)=(Pitch=100,Range=500)
    RangeTable(5)=(Pitch=125,Range=600)
    RangeTable(6)=(Pitch=150,Range=700)
    RangeTable(7)=(Pitch=175,Range=800)
    RangeTable(8)=(Pitch=200,Range=900)
    RangeTable(9)=(Pitch=225,Range=1000)
    RangeTable(10)=(Pitch=250,Range=1100)
    RangeTable(11)=(Pitch=275,Range=1200)
    RangeTable(12)=(Pitch=300,Range=1300)
    RangeTable(13)=(Pitch=325,Range=1350)
    RangeTable(14)=(Pitch=350,Range=1400)
    RangeTable(15)=(Pitch=375,Range=1500)
    RangeTable(16)=(Pitch=400,Range=1600)
    RangeTable(17)=(Pitch=425,Range=1650)
    RangeTable(18)=(Pitch=450,Range=1700)
    RangeTable(19)=(Pitch=475,Range=1750)
    RangeTable(20)=(Pitch=500,Range=1800)
    RangeTable(21)=(Pitch=525,Range=1850)
    AngleUnit="mils"
    
    SegmentSchema(0)=(Shape=MediumLengthTick,DrawLabel=true)
    SegmentSchema(1)=(Shape=ShortTick,DrawLabel=false)
    SegmentSchema(2)=(Shape=MediumLengthTick,DrawLabel=false)
    SegmentSchema(3)=(Shape=ShortTick,DrawLabel=false)
    SegmentSchema(4)=(Shape=MediumLengthTick,DrawLabel=false)
    SegmentSchema(5)=(Shape=LongTick,DrawLabel=false)
    SegmentSchema(6)=(Shape=MediumLengthTick,DrawLabel=false)
    SegmentSchema(7)=(Shape=ShortTick,DrawLabel=false)
    SegmentSchema(8)=(Shape=MediumLengthTick,DrawLabel=false)
    SegmentSchema(9)=(Shape=ShortTick,DrawLabel=false)
    
    NumberOfYawSegments = 4;
    NumberOfPitchSegments = 6;
}