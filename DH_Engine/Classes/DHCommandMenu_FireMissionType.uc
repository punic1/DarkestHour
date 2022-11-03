//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHCommandMenu_FireMissionType extends DHCommandMenu;

var DHRadio Radio;

var localized string FireMissionSmall;
var localized string FireMissionMedium;
var localized string FireMissionLarge;

function Setup()
{
    Radio = DHRadio(MenuObject);

    super.Setup();
}

function OnSelect(int Index, vector Location)
{
    local DHPlayer PC; 
    
    PC = GetPlayerController();

    switch (Index)
    {
        case 0:// Fire mission dependent upon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
            break;
        case 1:// Fire mission dependent upon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
            break;
        case 2:// Fire mission dependent upon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
            break;
    }
}

defaultproperties
{
    Options(0)=(ActionText="Fire-mission TRP",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
    Options(1)=(ActionText="Fire-mission Supressive",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
    Options(2)=(ActionText="Fire-mission Barrage",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
}
