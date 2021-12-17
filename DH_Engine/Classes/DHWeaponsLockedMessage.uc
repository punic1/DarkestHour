//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2021
//==============================================================================

class DHWeaponsLockedMessage extends LocalMessage
    abstract;

var localized string LockedSetupPhaseMessage;

// Modified to show appropriate weapons locked/unlocked message based on passed Switch value
static function string GetString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    return default.LockedSetupPhaseMessage;
}

// Modified to show message in red if weapon is locked, or white when unlocked
static function color GetColor(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2)
{
    return class'UColor'.default.White;
}

defaultproperties
{
    bFadeMessage=true
    bIsConsoleMessage=false
    bIsUnique=true
    Lifetime=5.0
    PosY=0.8
    LockedSetupPhaseMessage="Your weapons are locked during the setup phase"
}
