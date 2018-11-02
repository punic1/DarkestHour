//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2018
//==============================================================================

class DHRadioItem extends DHWeapon;

// TODO: ArtilleryTrigger seems to serve no purpose as an instance variable & should be made a local variable in AttachToPawn()
// The other 2 could probably also be removed & replaced with class/name literals as they are only used here & only once & will never change or be subclassed
var class<DHRadio>      RadioClass;
var DHRadio             Radio;
var name                AttachBoneName;

simulated function PreBeginPlay() // TODO: merge this into PostBeginPlay & perhaps add an authority role check
{
    local DHPawn P;

    P = DHPawn(Instigator);

    if (P == none || P.Radio != none)
    {
        Destroy();

        return;
    }

    super.PreBeginPlay();
}

simulated function PostBeginPlay()
{
    local DHPawn P;

    P = DHPawn(Instigator);

    if (P != none)
    {
        AttachToPawn(P);
    }

    super.PostBeginPlay();
}

function AttachToPawn(Pawn P)
{
    local DHGameReplicationInfo GRI;
    local DHPawn DHP;

    GRI = DHGameReplicationInfo(Level.Game.GameReplicationInfo);
    DHP = DHPawn(P);

    if (GRI == none || DHP == none || DHP.Radio != none)
    {
        return; // TODO: radio should destroy itself here as couldn't attach - although that will reintroduce the 'can't switch weapons' bug (as will the Destroy() in PreBeginPlay!)
    }

    Radio = Spawn(RadioClass, P);
    Radio.TeamIndex = DHP.GetTeamNum();
    Radio.Carrier = DHP;

    DHP.Radio = Radio;

    P.AttachToBone(Radio, AttachBoneName);
}

// Colin: The following functions make it impossible to select the radio as the
// current weapon.
simulated function Weapon WeaponChange(byte F, bool bSilent)
{
    if (Inventory != none)
    {
        return Inventory.WeaponChange(F, bSilent);
    }

    return none;
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
    if (Inventory != none)
    {
        return Inventory.NextWeapon(CurrentChoice, CurrentWeapon);
    }

    return none;
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
    if (Inventory != none)
    {
        return Inventory.PrevWeapon(CurrentChoice, CurrentWeapon);
    }

    return none;
}

defaultproperties // TODO: perhaps make this remote role none so it doesn't replicate as client doesn't need it,
{                 // then change DHPawn.VerifyGivenItems() so it skips check for inventory item if it has no remote role (i.e. client doesn't expect to receive it)?
    ItemName="Radio"
    InventoryGroup=10
    AttachmentClass=class'DH_Equipment.DHRadioAttachment'
    AttachBoneName="hip"
    RadioClass=class'DH_Engine.DHRadio'
    bCanThrow=false
    bCanSway=false
}
