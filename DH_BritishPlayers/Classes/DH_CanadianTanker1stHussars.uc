//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_CanadianTanker1stHussars extends DH_1stHussars;

defaultproperties
{
    MyName="Tank Crewman"
    AltName="Tank Crewman"
    Article="a "
    PluralName="Tank Crewmen"
    MenuImage=texture'DHCanadianCharactersTex.Icons.Can_TankCrew'
    Models(0)="Can_1stH1"
    Models(1)="Can_1stH2"
    Models(2)="Can_1stH3"
    SleeveTexture=texture'DHCanadianCharactersTex.Sleeves.CanadianSleeves'
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_StenMkIIWeapon')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_EnfieldNo2Weapon')
    GivenItems(0)="DH_Engine.DH_BinocularsItem"
    Headgear(0)=class'DH_BritishPlayers.DH_CanadianTankerBeret'
    PrimaryWeaponType=WT_SMG
    bEnhancedAutomaticControl=true
    bCanBeTankCrew=true
    Limit=3
}
