//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2023
//==============================================================================

class DH_RKKA_StandardAssaultLate extends DH_RKKA_StandardAssaultEarly;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicNocoatLatePawn',Weight=2.0)
    RolePawns(1)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicLatePawn',Weight=1.0)
    RolePawns(2)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43PawnA',Weight=1.0)
    RolePawns(3)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43PawnB',Weight=1.0)
    RolePawns(4)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43GreenPawnA',Weight=1.0)
    RolePawns(5)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43GreenPawnB',Weight=1.0)
    RolePawns(6)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43DarkPawnA',Weight=1.0)
    RolePawns(7)=(PawnClass=class'DH_SovietPlayers.DH_SovietTunicM43DarkPawnB',Weight=1.0)

    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_PPSH41Weapon',AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
    PrimaryWeapons(1)=(Item=class'DH_Weapons.DH_PPS43Weapon',AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
    PrimaryWeapons(2)=(Item=class'DH_Weapons.DH_PPSH41_stickWeapon',AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
}
