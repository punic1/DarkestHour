//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2020
//==============================================================================

class DH_45mmM1942GunCannon extends DH_45mmM1937GunCannon;

defaultproperties
{
    Mesh=SkeletalMesh'DH_45mm_anm.45mmM1942_gun'
    ProjectileClass=class'DH_Guns.DH_45mmM1942GunCannonShell'
    PrimaryProjectileClass=class'DH_Guns.DH_45mmM1942GunCannonShell'
    TertiaryProjectileClass=class'DH_Guns.DH_45mmM1942GunCannonShellAPCR'
    WeaponFireOffset=42.9
}
