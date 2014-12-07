//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_FG42Weapon extends DH_BipodAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\DH_Fallschirmgewehr42_1st.ukx

var name SelectFireAnim;
var name SelectFireIronAnim;
var name SightUpSelectFireIronAnim;

replication
{
    reliable if (Role < ROLE_Authority)
        ServerChangeFireMode;
}

simulated exec function SwitchFireMode()
{
    if (IsBusy() || FireMode[0].bIsFiring || FireMode[1].bIsFiring)
    {
        return;
    }

    GotoState('SwitchingFireMode');
}

function ServerChangeFireMode()
{
    FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
}

simulated state SwitchingFireMode extends Busy
{
    simulated function bool ReadyToFire(int Mode)
    {
        return false;
    }

    simulated function bool ShouldUseFreeAim()
    {
        return false;
    }

    simulated function Timer()
    {
        GotoState('Idle');
    }

    simulated function BeginState()
    {
        local name Anim;

        if (bUsingSights || Instigator.bBipodDeployed)
        {
            if (Instigator.bBipodDeployed && HasAnim(SightUpSelectFireIronAnim))
            {
                Anim = SightUpSelectFireIronAnim;
            }
            else
            {
                Anim = SelectFireIronAnim;
            }
        }
        else
        {
            Anim = SelectFireAnim;
        }

        if (Instigator.IsLocallyControlled())
        {
            PlayAnim(Anim, 1.0, FastTweenTime);
        }

        SetTimer(GetAnimDuration(SelectAnim, 1.0) + FastTweenTime, false);

        ServerChangeFireMode();

        if (Role < ROLE_Authority)
        {
            FireMode[0].bWaitForRelease = !FireMode[0].bWaitForRelease;
        }
    }
}

// used by the hud icons for select fire
simulated function bool UsingAutoFire()
{
    return !FireMode[0].bWaitForRelease;
}

defaultproperties
{
    SelectFireAnim="switch_fire"
    SelectFireIronAnim="Iron_switch_fire"
    SightUpSelectFireIronAnim="deploy_switch_fire"
    SightUpIronBringUp="Deploy"
    SightUpIronPutDown="undeploy"
    SightUpIronIdleAnim="deploy_idle"
    SightUpMagEmptyReloadAnim="deploy_reload_empty"
    SightUpMagPartialReloadAnim="deploy_reload_half"
    MaxNumPrimaryMags=6
    InitialNumPrimaryMags=6
    bHasSelectFire=true
    FireModeClass(0)=class'DH_Weapons.DH_FG42Fire'
    FireModeClass(1)=class'DH_Weapons.DH_FG42MeleeFire'
    PickupClass=class'DH_Weapons.DH_FG42Pickup'
    AttachmentClass=class'DH_Weapons.DH_FG42Attachment'
    ItemName="Fallschirmjägergewehr 42"
    Mesh=SkeletalMesh'DH_Fallschirmgewehr42_1st.FG42'
}
