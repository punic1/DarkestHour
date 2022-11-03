//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHCommandMenu_FireMissionType extends DHCommandMenu;

var DHRadio Radio;
var DH_LevelInfo LevelInfo;

var localized string FireMissionSmall;
var localized string FireMissionMedium;
var localized string FireMissionLarge;

function Setup()
{
    local int i;
    local Option O;
    local class<DHArtillery> ArtilleryClass;
    
    LevelInfo = class'DH_LevelInfo'.static.GetInstance(Interaction.ViewportOwner.Actor.Level);
    Radio = DHRadio(MenuObject);
    ArtilleryClass = LevelInfo.ArtilleryTypes[MenuInteger].ArtilleryClass;

    for (i = 0; i < ArtilleryClass.default.FireMissions.Length ; ++i)
    {
        O.ActionText = ArtilleryClass.default.FireMissions[i].MenuName;
        Options[Options.Length] = O;
    }
    
    super.Setup();
}


function OnSelect(int Index, vector Location)
{
    local DHPlayer PC; 
    
    PC = GetPlayerController();

    PC.ServerRequestArtillery(Radio, MenuInteger, Index);
    Interaction.Hide();

}

defaultproperties
{

}
