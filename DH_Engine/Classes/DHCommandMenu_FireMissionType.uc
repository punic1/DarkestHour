//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHCommandMenu_FireMissionType extends DHCommandMenu;

var DHRadio Radio;

var localized string FiremissionSmall;
var localized string FiremissionMedium;
var localized string FiremissionLarge;

function Setup()
{
    Radio = DHRadio(MenuObject);

}


function OnSelect(int Index, vector Location)
{
    local DHPlayer PC; 
    
    PC = GetPlayerController();

    switch (index)
    {
        Case 0:// Firemission dependant apon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
        Case 1:// Firemission dependant apon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
        Case 2:// Firemission dependant apon artillery class
            PC.ServerRequestArtillery(Radio, MenuInteger);
    }
}




defaultproperties
{
    Options(0)=(ActionText="Fire-mission TRP",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
    Options(1)=(ActionText="Fire-mission Surpressive",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
    Options(2)=(ActionText="Fire-mission Barrage",Material=Texture'DH_InterfaceArt2_tex.Icons.Artillery')
}
