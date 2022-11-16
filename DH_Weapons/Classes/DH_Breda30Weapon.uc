//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2020
//==============================================================================

class DH_Breda30Weapon extends DHAutoWeapon;

struct MagazineAnimation
{
    var int Channel;
    var name BoneName;
    var name Animation;
};
var array<MagazineAnimation> MagazineAnimations;

function SetupMagazineAnimationChannels()
{
    local int i;

    for (i = 0; i < MagazineAnimations.Length; ++i)
    {
        AnimBlendParams(MagazineAnimations[i].Channel, 1.0,,, MagazineAnimations[i].BoneName);
    }
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (InstigatorIsLocallyControlled())
    {
        SetupMagazineAnimationChannels();
    }
}

simulated function float GetMagazineRatio()
{
    return float(AmmoAmount(0)) / MaxAmmo(0);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    super.BringUp(PrevWeapon);

    if (InstigatorIsLocallyControlled())
    {
        UpdateMagazineAnimations(GetMagazineRatio());
    }
}

simulated function UpdateMagazineAnimations(float Theta)
{
    local int i;

    for (i = 0; i < MagazineAnimations.Length; ++i)
    {
        SetAnimFrame(Theta, MagazineAnimations[i].Channel);
    }
}

defaultproperties
{
    ItemName="Breda modello 30"

    //Mesh=SkeletalMesh'DH_Breda30_anm.breda30_1st'

    MagazineAnimations(0)=(Channel=1,BoneName="MAGAZINE_INTERNALS",Animation="MAGAZINE_ANIMATION_01")
}
