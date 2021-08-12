//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2020
//==============================================================================

class DH_SdKfz251_9DLateCamoWinter extends DH_SdKfz251_9DTransportLate;

defaultproperties
{
    bIsWinterVariant=true

    Skins(0)=Texture'DH_VehiclesGE_tex8.ext_vehicles.halftracksnow2_ext'
    Skins(1)=Texture'axis_vehicles_tex.Treads.Halftrack_treadsnow'
    Skins(2)=Texture'axis_vehicles_tex.Treads.Halftrack_treadsnow'

    CannonSkins(0)=Texture'DH_VehiclesGE_tex8.ext_vehicles.stummel_winter_ext'

    // TODO: Need a destroyed combiner for the winter variant!
    DestroyedMeshSkins(0)=combiner'DH_VehiclesGE_tex.Destroyed.halftrack_stripe_dest'
}
