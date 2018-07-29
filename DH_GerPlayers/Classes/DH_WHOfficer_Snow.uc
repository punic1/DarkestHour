//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2018
//==============================================================================

class DH_WHOfficer_Snow extends DHGEArtilleryOfficerRoles;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_GerPlayers.DH_GermanParkaSnowHeerPawn',Weight=2.0)
    RolePawns(1)=(PawnClass=class'DH_GerPlayers.DH_GermanSmockToqueHeerPawn',Weight=1.0)
    SleeveTexture=Texture'Weapons1st_tex.Arms.RussianSnow_Sleeves'
    Headgear(0)=class'DH_GerPlayers.DH_HeerHelmetSnow'
    Headgear(1)=class'DH_GerPlayers.DH_HeerHelmetCover'

    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_Kar98Weapon',AssociatedAttachment=class'ROInventory.ROKar98AmmoPouch')
}
