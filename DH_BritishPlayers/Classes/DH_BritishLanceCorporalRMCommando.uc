//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_BritishLanceCorporalRMCommando extends DH_RoyalMarineCommandos;

defaultproperties
{
    MyName="Lance Corporal"
    AltName="Lance Corporal"
    Article="a "
    PluralName="Lance Corporals"
    MenuImage=texture'DHBritishCharactersTex.Icons.Brit_LanceCorporal'
    Models(0)="RMC1"
    Models(1)="RMC2"
    Models(2)="RMC3"
    Models(3)="RMC4"
    Models(4)="RMC5"
    Models(5)="RMC6"
    SleeveTexture=texture'DHBritishCharactersTex.Sleeves.brit_sleeves'
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_EnfieldNo4Weapon')
    PrimaryWeapons(1)=(Item=class'DH_Weapons.DH_StenMkIIWeapon')
    PrimaryWeapons(2)=(Item=class'DH_Weapons.DH_ThompsonWeapon')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_EnfieldNo2Weapon')
    Grenades(0)=(Item=class'DH_Weapons.DH_M1GrenadeWeapon')
    Grenades(1)=(Item=class'DH_Equipment.DH_USSmokeGrenadeWeapon')
    Headgear(0)=class'DH_BritishPlayers.DH_BritishTurtleHelmet'
    Headgear(1)=class'DH_BritishPlayers.DH_BritishTurtleHelmetNet'
    Headgear(2)=class'DH_BritishPlayers.DH_BritishRMCommandoBeret'
    PrimaryWeaponType=WT_Rifle
    Limit=2
}
