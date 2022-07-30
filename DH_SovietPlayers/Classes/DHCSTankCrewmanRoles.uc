//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2021
//==============================================================================

class DHCSTankCrewmanRoles extends DHAlliedTankCrewmanRoles //WIP; to do: radio voices, uniforms
    abstract;

defaultproperties
{
    AltName="Tankista"
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_PPS43Weapon',AssociatedAttachment=class'ROInventory.ROPPS43AmmoPouch')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_Nagant1895Weapon')
    GivenItems(0)="DH_Equipment.DHBinocularsItemSoviet"
    SleeveTexture=Texture'Weapons1st_tex.Arms.RussianTankerSleeves'
    DetachedArmClass=class'ROEffects.SeveredArmSovTanker'
    DetachedLegClass=class'ROEffects.SeveredLegSovTanker'
    Headgear(0)=class'DH_SovietPlayers.DH_SovietTankerHat'
    VoiceType="DH_SovietPlayers.DHCzechVoice"
    AltVoiceType="DH_SovietPlayers.DHCzechVoice"
}
