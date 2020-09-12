//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHArtillerySpottingScope extends ROVehicle
    abstract;

// Range table
struct SRangeTableRecord
{
    var float Mils;     // Pitch, in mils.
    var float Range;    // Range, in meters.
    var float TTI;      // Time-to-impact in seconds
};
var array<SRangeTableRecord>    RangeTable;

var     localized string    RangeString;
var     localized string    ElevationString;
var     texture             SpottingScopeOverlay;           // periscope overlay texture

var     DHVehicleWeapon     VehWep;
var     float               YawScaleStep;               // how quickly yaw indicator should traverse
var     float               PitchScaleStep;             // how quickly pitch indicator should traverse
var     float               PitchIndicatorLength;
var     float               YawIndicatorLength;

simulated static function DrawSpottingScopeOverlay(Canvas C)
{
    local float TextureSize, TileStartPosU, TileStartPosV, TilePixelWidth, TilePixelHeight;

    if (default.SpottingScopeOverlay != none)
    {
        TextureSize = float(default.SpottingScopeOverlay.MaterialUSize());
        TilePixelWidth = TextureSize / 0.4 * 0.955;
        TilePixelHeight = TilePixelWidth * float(C.SizeY) / float(C.SizeX);
        TileStartPosU = ((TextureSize - TilePixelWidth) / 2.0);
        TileStartPosV = ((TextureSize - TilePixelHeight) / 2.0);
        C.SetPos(0.0, 0.0);

        C.DrawTile(default.SpottingScopeOverlay, C.SizeX, C.SizeY, TileStartPosU, TileStartPosV, TilePixelWidth, TilePixelHeight);
        //Log("ScreenRation=" @ ScreenRatio @ " C.SizeX=" @ C.SizeX @ " C.SizeY=" @ C.SizeY @ " default.SpottingScopeOverlay.VSize=" @ default.SpottingScopeOverlay.VSize);
        //C.SetPos(0.0, 0.0);
        //C.DrawTile(default.SpottingScopeOverlay, C.SizeX, C.SizeY, 0.0, (1.0 - ScreenRatio) * float(default.SpottingScopeOverlay.VSize) * 0.3, default.SpottingScopeOverlay.USize, float(default.SpottingScopeOverlay.VSize) * ScreenRatio * 0.85);
    }
}

simulated static function DrawRangeTable(Canvas C)
{
    local int i;
    local float X, Y;
    local float XL, YL;
    local float TableWidth, TableHeight;
    const FirstColumn = 45;
    const SecondColumn = 185;

    if (default.RangeTable.Length == 0)
    {
        return;
    }

    C.Font = C.TinyFont;
    C.TextSize("A", XL, YL);

    TableWidth = 280.0;
    TableHeight = (default.RangeTable.Length + 3) * YL;     // plus 3 because of table header and to have pretty spacing

    Y = (C.SizeY - TableHeight) / 2;
    X = C.SizeX * 0.75;

    // draw table background
    C.SetPos(X, Y);
    C.SetDrawColor(255, 255, 255, 255);
    C.DrawTile(Texture'Engine.WhiteSquareTexture', TableWidth, TableHeight, 0, 0, 2, 2);

    // draw table header
    C.SetDrawColor(0, 0, 0, 255);
    C.SetPos(X + SecondColumn + 7, Y + 3);
    C.DrawText(default.RangeString);
    C.SetPos(X + FirstColumn, Y + 3);
    C.DrawText(default.ElevationString);
    C.SetPos(X, Y);
    C.DrawVertical(X + TableWidth / 2, TableHeight);
    C.SetPos(X, Y);
    Y += YL + 8;
    C.DrawHorizontal(Y, TableWidth);

    // draw table rows
    for (i = 0; i < default.RangeTable.Length; ++i)
    {
        Y += YL;
        C.SetPos(X + FirstColumn, Y);
        C.DrawText(string(default.RangeTable[i].Range) $ "m");
        C.SetPos(X + SecondColumn, Y);
        C.DrawText(string(default.RangeTable[i].Mils) $ "mils");
    }
}

simulated static function DrawYaw(Canvas C, float CurrentYaw, float GunYawMin, float GunYawMax)
{
    local float i, StepX, X, Y, YawUpperBound, YawLowerBound, SegmentCount, IndicatorStep;
    local int Shade, Quotient, t;
    local string Label;
    const VISIBLE_YAW_SEGMENTS = 40; // total number of ticks on a yaw indicator

    X = C.SizeX * 0.5 - default.YawIndicatorLength * 0.5;
    Y = C.SizeY * 0.93;

    //CurrentYaw = class'DHUnits'.static.UnrealToMilliradians(GetGunYaw());
    YawLowerBound = class'UMath'.static.Floor(CurrentYaw, default.YawScaleStep) - default.YawScaleStep * VISIBLE_YAW_SEGMENTS/2;
    YawUpperBound = class'UMath'.static.Floor(CurrentYaw, default.YawScaleStep) + default.YawScaleStep * VISIBLE_YAW_SEGMENTS/2;
    SegmentCount = (YawUpperBound - YawLowerBound) / default.YawScaleStep;
    StepX = (YawUpperBound - YawLowerBound) / SegmentCount;
    IndicatorStep = default.YawIndicatorLength / VISIBLE_YAW_SEGMENTS;

    C.Font = C.TinyFont;

    // Draw a long horizontal bar that imitates edge of the indicator
    C.CurX = X;
    C.CurY = Y;
    C.DrawHorizontal(Y, default.YawIndicatorLength);

    // Start drawing scale ticks
    C.CurY = Y - 5.0;

    for(i = YawLowerBound; i <= YawUpperBound; i = i + StepX)
    {
        // Calculate index of the tick in the indicator reference frame 
        t = (i - YawLowerBound) / StepX;

        // Calculate color of the current indicator tick
        Shade = Max(1, 255 * class'UInterp'.static.Mimi(float(t) / VISIBLE_YAW_SEGMENTS));

        // Calculate index of the current readout value on the mortar yaw span
        Quotient = class'UMath'.static.FlooredDivision(i, default.YawScaleStep);

        Label = string(class'UMath'.static.Floor(i, default.YawScaleStep));

        // Changing alpha chanel works fine until the value gets lower than ~127 - from this point
        // text labels completly disappear. I propose to change the color instead of alpha channel
        // because the background is black anyway. - mimi~
        C.SetDrawColor(Shade, Shade, Shade, 255);

        C.CurY = Y - 5.0;
        // 3 is a rough factor to compensate X position of the label with respect to number of letters
        C.CurX = X + t * default.YawIndicatorLength / SegmentCount - Len(Label) * 3;

        if (Quotient % 10 == 0)
        {
            //Log("i="@i@"Quotient="@Quotient@"Label="@Label);
            // Draw long vertical tick & label it
            C.DrawVertical(X + (t * IndicatorStep), -50.0);
            C.CurY = Y - 70.0;
            C.DrawText(Label);
        }
        else if (Quotient % 5 == 0)
        {
            // Draw middle-sized vertical tick & label it
            C.DrawVertical(X + (t * IndicatorStep), -30.0);
            C.CurY = Y - 50.0;
            C.DrawText(Label);
        }
        else
        {
            // Smallest granularity - draw short vertical tick (no label)
            C.DrawVertical(X + (t * IndicatorStep), -20.0);
        }

        // Draw a strike-through if this segment is beyond the lower or upper limits.
        if (i < class'UMath'.static.Floor(GunYawMin, default.YawScaleStep)) // class'DHUnits'.static.UnrealToMilliradians(GetGunYawMin())
        {
            //Log(class'UMath'.static.Floor(i, default.YawScaleStep) @ "is below " @ class'DHUnits'.static.UnrealToMilliradians(GetGunYawMin()));
            C.CurX = X + t * default.YawIndicatorLength / SegmentCount;
            C.DrawHorizontal(Y - 15, IndicatorStep);
        }

        if (i > class'UMath'.static.Floor(GunYawMax, default.YawScaleStep)) // class'DHUnits'.static.UnrealToMilliradians(GetGunYawMax())
        {
            C.CurX = X + t * default.YawIndicatorLength / SegmentCount;
            C.DrawHorizontal(Y - 15, -IndicatorStep);
        }
    }

    // Draw current value indicator (middle tick)
    C.SetDrawColor(255, 255, 255, 255);
    C.CurY = Y + 15.0;
    C.DrawVertical(X + (default.YawIndicatorLength / 2), 20.0);
}
    
simulated static function DrawPitch(Canvas C, float CurrentPitch, float GunPitchMin, float GunPitchMax)
{
    local float i, StepY, X, Y, PitchUpperBound, PitchLowerBound, SegmentCount, IndicatorStep;
    local int Shade, Quotient, t;
    local string Label;
    const VISIBLE_PITCH_SEGMENTS = 40; // total number of ticks on a yaw indicator

    X = C.SizeX * 0.25;
    Y = C.SizeY * 0.5 - default.PitchIndicatorLength * 0.5;

    //CurrentPitch = class'DHUnits'.static.UnrealToMilliradians(GetGunPitch());
    PitchLowerBound = class'UMath'.static.Floor(CurrentPitch, default.PitchScaleStep) - default.PitchScaleStep * VISIBLE_PITCH_SEGMENTS/2;
    PitchUpperBound = class'UMath'.static.Floor(CurrentPitch, default.PitchScaleStep) + default.PitchScaleStep * VISIBLE_PITCH_SEGMENTS/2;
    SegmentCount = (PitchUpperBound - PitchLowerBound) / default.PitchScaleStep;
    StepY = (PitchUpperBound - PitchLowerBound) / SegmentCount;
    IndicatorStep = default.PitchIndicatorLength / VISIBLE_PITCH_SEGMENTS;

    C.Font = C.TinyFont;

    // Start drawing scale ticks
    for(i = PitchLowerBound; i <= PitchUpperBound; i = i + StepY)
    {
        // Calculate index of the tick in the indicator reference frame 
        t = VISIBLE_PITCH_SEGMENTS - (i - PitchLowerBound) / StepY;

        // Calculate color of the current indicator tick
        Shade = Max(1, 255 * class'UInterp'.static.Mimi(float(t) / VISIBLE_PITCH_SEGMENTS));

        // Calculate index of the current readout value on the mortar yaw span
        Quotient = class'UMath'.static.FlooredDivision(i, default.PitchScaleStep);

        Label = string(class'UMath'.static.Floor(i, default.PitchScaleStep));

        // Changing alpha chanel works fine until the value gets lower than ~127 - from this point
        // text labels completly disappear. I propose to change the color instead of alpha channel
        // because the background is black anyway. - mimi~
        C.SetDrawColor(Shade, Shade, Shade, 255);

        C.CurX = X - 5.0;
        C.CurY = Y + t * default.PitchIndicatorLength / SegmentCount;

        if (Quotient % 10 == 0)
        {
            //Log("i="@i@"Quotient="@Quotient@"Label="@Label);
            // Draw long vertical tick & label it
            C.DrawHorizontal(Y + (t * IndicatorStep), -50.0);

            // 3 is a rough factor to compensate X position of the label with respect to number of letters
            C.CurX = X - 60.0 - Len(Label) * 6;

            // Readjust label height so it is on the same level as the tick
            C.CurY = C.CurY - 5;
            
            C.DrawText(Label);
        }
        else if (Quotient % 5 == 0)
        {
            // Draw middle-sized vertical tick & label it
            C.DrawHorizontal(Y + (t * IndicatorStep), -30.0);

            // 3 is a rough factor to compensate X position of the label with respect to number of letters
            C.CurX = X - 40.0 - Len(Label) * 6;
            
            // Readjust label height so it is on the same level as the tick
            C.CurY = C.CurY - 5;

            C.DrawText(Label);
        }
        else
        {
            // Smallest granularity - draw short vertical tick (no label)
            C.DrawHorizontal(Y + (t * IndicatorStep), -20.0);
        }

        // Draw a strike-through if this segment is below the lower limit.
        if (i < class'UMath'.static.Floor(GunPitchMin, default.PitchScaleStep))
        {
            C.CurY = Y + t * default.PitchIndicatorLength / SegmentCount;
            C.DrawVertical(X - 15, -IndicatorStep);
        }

        // Draw a strike-through if this segment is above the upper limit.
        if (i > class'UMath'.static.Floor(GunPitchMax, default.PitchScaleStep))
        {
            C.CurY = Y + t * default.PitchIndicatorLength / SegmentCount;
            C.DrawVertical(X - 15, IndicatorStep);
        }
    }

    // Draw a long horizontal bar that imitates edge of the indicator
    C.SetDrawColor(255, 255, 255, 255);
    C.CurY = Y;
    C.DrawVertical(X, default.PitchIndicatorLength);

    // Draw current value indicator (middle tick)
    C.SetDrawColor(255, 255, 255, 255);
    C.CurX = X + 15.0;
    C.DrawHorizontal(Y + (default.PitchIndicatorLength / 2), 20.0);
}

defaultproperties 
{
    SpottingScopeOverlay=Texture'DH_VehicleOptics_tex.German.German_sight_background'
    YawScaleStep = 1.0
    PitchScaleStep = 1.0

    PitchIndicatorLength = 300.0
    YawIndicatorLength = 300.0

}