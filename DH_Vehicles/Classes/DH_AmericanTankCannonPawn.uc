//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_AmericanTankCannonPawn extends DH_ROTankCannonPawn
       abstract;

var     texture                 PeriscopeOverlay;

//Allows for periscope overlay
simulated function DrawHUD(Canvas Canvas)
{
    local PlayerController PC;
    local vector CameraLocation;
    local rotator CameraRotation;
    local Actor ViewActor;
    local float SavedOpacity;
    local float scale;
    local float posx, posy;

    local float ScreenRatio, OverlayCenterTexStart, OverlayCenterTexSize;

    PC = PlayerController(Controller);
    if (PC == none)
    {
        super.RenderOverlays(Canvas);
        //log("PanzerTurret PlayerController was none, returning");
        return;
    }
    else if (!PC.bBehindView)
    {
        // store old opacity and set to 1.0 for map overlay rendering
        SavedOpacity = Canvas.ColorModulate.W;
        Canvas.ColorModulate.W = 1.0;

        Canvas.DrawColor.A = 255;
        Canvas.Style = ERenderStyle.STY_Alpha;

                scale = Canvas.SizeY / 1200.0;

         if (DriverPositions[DriverPositionIndex].bDrawOverlays && !IsInState('ViewTransition'))
         {
            if (DriverPositionIndex == 0)
            {
                // Calculate reticle drawing position (and position to draw black bars at)
                if (bShowCenter)
                {
                    //debug, draw cross on the center of the screen
                    posx=Canvas.SizeX / 2;
                    posy=Canvas.SizeY / 2;
                    Canvas.SetPos(0, 0);
                    Canvas.DrawVertical(posx-1, posy-3);
                    Canvas.DrawVertical(posx, posy-3);
                    Canvas.SetPos(0, posy+3);
                    Canvas.DrawVertical(posx-1, posy-3);
                    Canvas.DrawVertical(posx, posy-3);
                    Canvas.SetPos(0, 0);
                    Canvas.DrawHorizontal(posy-1, posx-3);
                    Canvas.DrawHorizontal(posy, posx-3);
                    Canvas.SetPos(posx+3, 0);
                    Canvas.DrawHorizontal(posy-1, posx-3);
                    Canvas.DrawHorizontal(posy, posx-3);
                }

                // Draw reticle
                ScreenRatio = float(Canvas.SizeY) / float(Canvas.SizeX);
                OverlayCenterScale = 0.955 / OverlayCenterSize; // 0.955 factor widens visible FOV to full screen width = OverlaySize 1.0
                OverlayCenterTexStart = (1 - OverlayCenterScale) * float(CannonScopeOverlay.USize) / 2;
                OverlayCenterTexSize =  float(CannonScopeOverlay.USize) * OverlayCenterScale;
                Canvas.SetPos(0,0);
                Canvas.DrawTile(CannonScopeOverlay , Canvas.SizeX , Canvas.SizeY, OverlayCenterTexStart - OverlayCorrectionX, OverlayCenterTexStart - OverlayCorrectionY + (1 - ScreenRatio) * OverlayCenterTexSize / 2 , OverlayCenterTexSize, OverlayCenterTexSize * ScreenRatio);

                if (Gun != none && Gun.ProjectileClass != none)
                    Canvas.SetPos(ScopePositionX * Canvas.ClipY / ScreenRatio / OverlayCenterScale - (Canvas.ClipX / OverlayCenterScale - Canvas.ClipX) / 2, (Gun.ProjectileClass.static.GetYAdjustForRange(Gun.GetRange()) * Canvas.ClipY / ScreenRatio / OverlayCenterScale) - Canvas.ClipY * (1/ScreenRatio/OverlayCenterScale - 1) / 2);
                else
                    Canvas.SetPos(ScopePositionX * Canvas.ClipY / ScreenRatio / OverlayCenterScale - (Canvas.ClipX / OverlayCenterScale - Canvas.ClipX) / 2, ScopePositionY  * Canvas.ClipY / ScreenRatio / OverlayCenterScale - Canvas.ClipY * (1/ScreenRatio/OverlayCenterScale-1)/2);
            }
            else if (DriverPositionIndex == PeriscopePositionIndex)
            {

                DrawPeriscopeOverlay(Canvas);
            }
            else
            {

                DrawBinocsOverlay(Canvas);
            }
        }

        // reset HudOpacity to original value
        Canvas.ColorModulate.W = SavedOpacity;

        // Draw tank, turret, ammo count, passenger list
        if (ROHud(PC.myHUD) != none && ROVehicle(GetVehicleBase()) != none)
            ROHud(PC.myHUD).DrawVehicleIcon(Canvas, ROVehicle(GetVehicleBase()), self);
    }

     // Zap the lame crosshair - Ramm
    if (IsLocallyControlled() && Gun != none && Gun.bCorrectAim && Gun.bShowAimCrosshair)
    {
        Canvas.DrawColor = CrosshairColor;
        Canvas.DrawColor.A = 255;
        Canvas.Style = ERenderStyle.STY_Alpha;
        Canvas.SetPos(Canvas.SizeX*0.5-CrosshairX, Canvas.SizeY*0.5-CrosshairY);
        Canvas.DrawTile(CrosshairTexture, CrosshairX*2.0, CrosshairY*2.0, 0.0, 0.0, CrosshairTexture.USize, CrosshairTexture.VSize);
    }

    if (PC != none && !PC.bBehindView && HUDOverlay != none)
    {
        if (!Level.IsSoftwareRendering())
        {
            CameraRotation = PC.Rotation;
            SpecialCalcFirstPersonView(PC, ViewActor, CameraLocation, CameraRotation);
            HUDOverlay.SetLocation(CameraLocation + (HUDOverlayOffset >> CameraRotation));
            HUDOverlay.SetRotation(CameraRotation);
            Canvas.DrawActor(HUDOverlay, false, false, FClamp(HUDOverlayFOV * (PC.DesiredFOV / PC.DefaultFOV), 1, 170));
        }
    }
    else
        ActivateOverlay(false);
}

simulated function DrawPeriscopeOverlay(Canvas Canvas)
{
    local float ScreenRatio;

    ScreenRatio = float(Canvas.SizeY) / float(Canvas.SizeX);
    Canvas.SetPos(0,0);
    Canvas.DrawTile(PeriscopeOverlay, Canvas.SizeX, Canvas.SizeY, 0.0 , (1 - ScreenRatio) * float(PeriscopeOverlay.VSize) / 2, PeriscopeOverlay.USize, float(PeriscopeOverlay.VSize) * ScreenRatio);
}

defaultproperties
{
    PeriscopeOverlay=texture'DH_VehicleOptics_tex.Allied.PERISCOPE_overlay_Allied'
    bShowRangeText=false
    OverlayCenterSize=1.000000
    DestroyedScopeOverlay=texture'DH_VehicleOptics_tex.Allied.Destroyed'
    ScopePositionX=0.215000
    ScopePositionY=0.500000
    BinocsOverlay=texture'DH_VehicleOptics_tex.Allied.BINOC_overlay_7x50Allied'
    RangeText="Yards"
}
