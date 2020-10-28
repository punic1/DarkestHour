//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2020
//==============================================================================
// Halloween Special 2020

class DH_ZAssault extends DHGEAssaultRoles;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_GerPlayers.DH_ZombieHeerPawn',Weight=1.0)
    RolePawns(1)=(PawnClass=class'DH_GerPlayers.DH_ZombieSmockHeerPawn',Weight=0.2)

    SleeveTexture=Texture'Weapons1st_tex.Arms.german_sleeves'

    Headgear(0)=class'DH_GerPlayers.DH_HeerHelmetThree'
    Headgear(1)=class'DH_GerPlayers.DH_HeerHelmetTwo'
    Headgear(2)=none
}