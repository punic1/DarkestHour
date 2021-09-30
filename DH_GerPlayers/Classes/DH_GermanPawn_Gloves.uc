//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2021
//==============================================================================

class DH_GermanPawn_Gloves extends DHPawn;

defaultproperties
{
    Species=class'DH_Engine.DHSPECIES_Human'

    Mesh=SkeletalMesh'DHCharactersGER_anm.Ger_Soldat'
    Skins(0)=Texture'Characters_tex.ger_heads.ger_face01'
    Skins(1)=Texture'DHGermanCharactersTex.Heer.WH_1'

    bReversedSkinsSlots=true

    FaceSkins(0)=Combiner'DHGermanCharactersTex.Heads.ger_face01Gloves'
    FaceSkins(1)=Combiner'DHGermanCharactersTex.Heads.ger_face02Gloves'
    FaceSkins(2)=Combiner'DHGermanCharactersTex.Heads.ger_face03Gloves'
    FaceSkins(3)=Combiner'DHGermanCharactersTex.Heads.ger_face04Gloves'
    FaceSkins(4)=Combiner'DHGermanCharactersTex.Heads.ger_face05Gloves'
    FaceSkins(5)=Combiner'DHGermanCharactersTex.Heads.ger_face06Gloves'
    FaceSkins(6)=Combiner'DHGermanCharactersTex.Heads.ger_face07Gloves'
    FaceSkins(7)=Combiner'DHGermanCharactersTex.Heads.ger_face08Gloves'
    FaceSkins(8)=Combiner'DHGermanCharactersTex.Heads.ger_face09Gloves'
    FaceSkins(9)=Combiner'DHGermanCharactersTex.Heads.ger_face10Gloves'
    FaceSkins(10)=Combiner'DHGermanCharactersTex.Heads.ger_face11Gloves'
    FaceSkins(11)=Combiner'DHGermanCharactersTex.Heads.ger_face12Gloves'
    FaceSkins(12)=Combiner'DHGermanCharactersTex.Heads.ger_face13Gloves'
    FaceSkins(13)=Combiner'DHGermanCharactersTex.Heads.ger_face14Gloves'
    FaceSkins(14)=Combiner'DHGermanCharactersTex.Heads.ger_face15Gloves'

    ShovelClassName="DH_Equipment.DHShovelItem_German"
    BinocsClassName="DH_Equipment.DHBinocularsItemGerman"
}
