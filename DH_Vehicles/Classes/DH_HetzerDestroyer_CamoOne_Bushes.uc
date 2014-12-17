//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_HetzerDestroyer_CamoOne_Bushes extends DH_HetzerDestroyer;

static function StaticPrecache(LevelInfo L)
{
    super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_body_camo1');
    L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_int');
    L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.Hetzer_driver_glass');
    L.AddPrecacheMaterial(Material'VegetationSMT.WildBushes.WildBush_A');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_body_camo1');
    Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
    Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_int');
    Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.Hetzer_driver_glass');
    Level.AddPrecacheMaterial(Material'VegetationSMT.WildBushes.WildBush_A');

    super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
    PassengerWeapons(0)=(WeaponPawnClass=class'DH_Vehicles.DH_HetzerCannonPawn_CamoOne')
    PassengerWeapons(1)=(WeaponPawnClass=class'DH_Vehicles.DH_HetzerMountedMGPawn_CamoOne')
    Skins(0)=texture'DH_Hetzer_tex_V1.hetzer_body_camo1'
    Skins(3)=texture'VegetationSMT.WildBushes.WildBush_A'
}
