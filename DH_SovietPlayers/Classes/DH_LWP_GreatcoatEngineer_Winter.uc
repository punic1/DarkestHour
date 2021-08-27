//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2021
//==============================================================================

class DH_LWP_GreatcoatEngineer_Winter extends DHPOLEngineerRoles;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_SovietPlayers.DH_LWPGreatcoatBrownBagPawn_Winter',Weight=4.0)
    RolePawns(1)=(PawnClass=class'DH_SovietPlayers.DH_LWPGreatcoatGreyBagPawn_Winter',Weight=1.0)
    SleeveTexture=Texture'DHSovietCharactersTex.RussianSleeves.DH_LWPCoatSleeves'
    Headgear(0)=class'DH_SovietPlayers.DH_LWPHelmet'
    
    HandType=Hand_Gloved
    GlovedHandTexture=Texture'DHSovietCharactersTex.soviet_gear.hands_sovgloves'
    BareHandTexture=Texture'DHSovietCharactersTex.soviet_gear.hands_sovgloves'
    CustomHandTexture=Texture'DHSovietCharactersTex.soviet_gear.hands_sovgloves'

}
