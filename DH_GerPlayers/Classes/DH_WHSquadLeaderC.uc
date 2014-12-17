//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_WHSquadLeaderC extends DH_HeerCamo;

function class<ROHeadgear> GetHeadgear()
{
    if (FRand() < 0.2)
        return Headgear[0];
    else
        return Headgear[1];
}

defaultproperties
{
    bIsSquadLeader=true
    MyName="Squad Leader"
    AltName="Unteroffizier"
    Article="a "
    PluralName="Squad Leaders"
    InfoText="The squad leader is tasked with overseeing the completion of the squad's objectives by directing his men in combat and ensuring the overall firepower is put to good use.  With the effective use of smoke and close-quarters weaponry, the squad leader's presence is an excellent force multiplier to the units under his command."
    MenuImage=texture'DHGermanCharactersTex.Icons.WH_SqL'
    Models(0)="WH_C1"
    Models(1)="WH_C2"
    Models(2)="WH_C3"
    Models(3)="WH_C4"
    bIsLeader=true
    SleeveTexture=texture'Weapons1st_tex.Arms.german_sleeves'
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_MP40Weapon',Amount=6,AssociatedAttachment=class'ROInventory.ROMP40AmmoPouch')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_P38Weapon',Amount=1)
    SecondaryWeapons(1)=(Item=class'DH_Weapons.DH_P08LugerWeapon',Amount=1)
    Grenades(0)=(Item=class'DH_Weapons.DH_StielGranateWeapon',Amount=2)
    Grenades(1)=(Item=class'DH_Equipment.DH_NebelGranate39Weapon',Amount=1)
    Grenades(2)=(Item=class'DH_Equipment.DH_OrangeSmokeWeapon',Amount=1)
    Headgear(0)=class'DH_GerPlayers.DH_HeerCamoCap'
    Headgear(1)=class'ROInventory.ROGermanHat'
    PrimaryWeaponType=WT_SMG
    bEnhancedAutomaticControl=true
    Limit=2
}
