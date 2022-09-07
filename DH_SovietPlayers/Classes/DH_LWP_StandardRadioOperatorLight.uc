//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DH_LWP_StandardRadioOperatorLight extends DHPOLRadioOperatorRoles;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_SovietPlayers.DH_LWPTunicStrapsLightPawn',Weight=1.0)
    Headgear(0)=class'DH_SovietPlayers.DH_LWPcap'
    Headgear(1)=class'DH_SovietPlayers.DH_LWPHelmet'
    HeadgearProbabilities(0)=0.5
    HeadgearProbabilities(1)=0.5

    SleeveTexture=Texture'DHSovietCharactersTex.RussianSleeves.LWP_light_sleeves'
	Backpack(0)=(BackpackClass=class'DH_SovietPlayers.DH_SovRadioBackpack',LocationOffset=(X=-0.1))
}