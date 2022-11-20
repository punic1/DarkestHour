//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2020
//==============================================================================
// TODO:
//  * Add satchel anti-tank functionality.
//  * Add a pickup class (requires implementaion in the superclass)
//  * Replace explosion effects and sounds.

class DH_RPG40GrenadeProjectile extends DHThrowableExplosiveProjectile;

var float           UnderneathDamageMultiplier; // Damage Multiplier for when the satchel dets under a vehicle

var float           ConstructionDamageRadius;   // A radius that will damage Contructions
var float           ConstructionDamageMax;

var float           ObstacleDamageRadius;       // A radius that will damage Obstacles
var float           ObstacleDamageMax;

var float           EngineDamageMassThreshold;  // A mass threshold at which a vehicle will take min damage instead of setting the engine on fire
var float           EngineDamageRadius;         // A radius that will damage Vehicle Engines
var float           EngineDamageMax;

var float           TreadDamageMassThreshold;   // A mass threshold at which a vehicle will take min damage instead of destroying the tread outright
var float           TreadDamageRadius;          // A radius that will damage Vehicle Treads
var float           TreadDamageMax;

// Modified to record SavedInstigator & SavedPRI
// RODemolitionChargePlacedMsg from ROSatchelChargeProjectile is omitted
simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Instigator != none)
    {
        SavedInstigator = Instigator;
        SavedPRI = Instigator.PlayerReplicationInfo;
    }
}

// Modified to check whether satchel blew up in a special Volume that needs to be triggered
simulated function BlowUp(vector HitLocation)
{
    if (Instigator != none)
    {
        SavedInstigator = Instigator;
        SavedPRI = Instigator.PlayerReplicationInfo;
    }

    if (Role == ROLE_Authority)
    {
        DelayedHurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation);
        HandleObjSatchels(HitLocation);
        HandleVehicles(HitLocation);
        HandleObstacles(HitLocation);
        HandleConstructions(HitLocation);
        MakeNoise(1.0);
    }
}

function HandleObjSatchels(vector HitLocation)
{
    local DH_ObjSatchel SatchelObjActor;
    local Volume        V;

    foreach TouchingActors(class'Volume', V)
    {
        if (DH_ObjSatchel(V.AssociatedActor) != none)
        {
            SatchelObjActor = DH_ObjSatchel(V.AssociatedActor);

            if (SatchelObjActor.WithinArea(self))
            {
                SatchelObjActor.Trigger(self, SavedInstigator);
            }
        }

        if (V.IsA('RODemolitionVolume'))
        {
            RODemolitionVolume(V).Trigger(self, SavedInstigator);
        }
    }
}

function HandleVehicles(vector HitLocation)
{
    local Actor         A;
    local vector        HitLoc, HitNorm;
    local DHVehicle     Veh;
    local int           TrackNum;
    local float         Distance;
    local bool          bExplodedOnVehicle, bExplodedUnderVehicle;

    // Find out if we are on a vehicle
    A = Trace(HitLoc, HitNorm, Location - vect(0.0, 0.0, 16.0), Location, true);
    bExplodedOnVehicle = DHVehicle(A) != none;

    // Find out if we are under a vehicle
    if (!bExplodedOnVehicle)
    {
        A = Trace(HitLoc, HitNorm, Location + vect(0.0, 0.0, 32.0), Location, true);
        bExplodedUnderVehicle = DHVehicle(A) != none;
    }

    // Handle vehicle component damage
    foreach RadiusActors(class'DHVehicle', Veh, DamageRadius)
    {
        // If this is the vehicle we exploded on or under
        if (Veh == A)
        {
            // Handle engine damage
            if (bExplodedOnVehicle && !Veh.IsVehicleBurning())
            {
                Distance = VSize(Location - Veh.GetEngineLocation());

                if (Distance < EngineDamageRadius)
                {
                    // If enough strength, set the engine on fire
                    if (EngineDamageMassThreshold > Veh.VehicleMass * Veh.SatchelResistance)
                    {
                        Veh.StartEngineFire(SavedInstigator);
                    }
                    else // Otherwise do minor damage to the engine
                    {
                        Veh.DamageEngine(EngineDamageMax * (Distance / EngineDamageRadius), SavedInstigator, vect(0,0,0), vect(0,0,0), MyDamageType);
                    }
                }
            }

            // Handle doing additional damage if exploded underneath vehicle
            if (bExplodedUnderVehicle)
            {
                Veh.TakeDamage(Damage * UnderneathDamageMultiplier, SavedInstigator, vect(0,0,0), vect(0,0,0), MyDamageType);
            }
        }

        // Set Distance to TreadDamageRadius, we don't want TreadDamageRadius to change, but want Distance to be changed in IsTreadInRadius()
        Distance = TreadDamageRadius;

        // Handle destroying the treads
        if (Veh.bHasTreads && Veh.IsTreadInRadius(Location, Distance, TrackNum))
        {
            // If enough strength we can detrack the vehicle instantly
            if (TreadDamageMassThreshold > Veh.VehicleMass * Veh.SatchelResistance)
            {
                Veh.DestroyTrack(bool(TrackNum));
            }
            else // Otherwise do minor damge to the tracks
            {
                Veh.DamageTrack(TreadDamageMax * (Distance / TreadDamageRadius), bool(TrackNum));
            }
        }
    }
}

// Allows satchels to damage obstacles when behind world geometry
function HandleObstacles(vector HitLocation)
{
    local DHObstacleInstance O;
    local float              Distance;

    foreach RadiusActors(class'DHObstacleInstance', O, ObstacleDamageRadius)
    {
        // If we cannot trace the obstacle (because of world geometry), then apply special radius damage
        if (O != none && !FastTrace(O.Location, Location))
        {
            Distance = VSize(Location - O.Location);
            O.TakeDamage(ObstacleDamageMax * (Distance / ObstacleDamageRadius), SavedInstigator, vect(0,0,0), vect(0,0,0), MyDamageType);
        }
    }
}

// Allows satchels to do damage to constructions when traces fail (useful if construction is on the otherside of terrain or origin under world)
function HandleConstructions(vector HitLocation)
{
    local DHConstruction    C;
    local float             Distance;

    foreach RadiusActors(class'DHConstruction', C, ConstructionDamageRadius)
    {
        // If we cannot trace the construction (because trace hit world geometry), then apply special radius damage
        if (C != none && !FastTrace(C.Location, Location))
        {
            Distance = VSize(Location - C.Location);
            C.TakeDamage(ConstructionDamageMax * (Distance / ConstructionDamageRadius), SavedInstigator, vect(0,0,0), vect(0,0,0), MyDamageType);
        }
    }
}

// Implemented here to go to dynamic lighting for a split second, when satchel blows up // TODO: doesn't appear to do anything noticeable?
simulated function WeaponLight()
{
    if (!Level.bDropDetail)
    {
        bDynamicLight = true;
        SetTimer(0.15, false);
    }
}

simulated function Timer()
{
    bDynamicLight = false;
}

defaultproperties
{
    StaticMesh=StaticMesh'DH_WeaponPickups.Ammo.RPG40'

    // Impact
    bExplodeOnImpact=true
    MaxImpactAOIToExplode=90.0
    MinImpactSpeedToExplode=0.0

    // Damage
    Damage=760.0 // 760 grams of TNT
    DamageRadius=780.0

    MyDamageType=class'DH_Weapons.DH_RPG40GrenadeDamType'

    // Effects
    ExplosionDecal=class'ROEffects.GrenadeMark'
    ExplosionDecalSnow=class'ROEffects.GrenadeMarkSnow'
    ExplodeDirtEffectClass=class'GrenadeExplosion'
    ExplodeSnowEffectClass=class'GrenadeExplosion'
    ExplodeMidAirEffectClass=class'GrenadeExplosion'

    // Sounds
    ExplosionSound(0)=SoundGroup'DH_MN_InfantryWeapons_sound.PIAT.PiatExp01'
    ExplosionSound(1)=SoundGroup'DH_MN_InfantryWeapons_sound.PIAT.PiatExp01'
    ExplosionSound(2)=SoundGroup'DH_MN_InfantryWeapons_sound.PIAT.PiatExp01'
    ImpactSound=Sound'Inf_Weapons_Foley.grenadeland'
    //ExplosionSoundVolume=10.0

    EngineDamageMassThreshold=15.1
    EngineDamageRadius=220.0
    EngineDamageMax=800.0

    TreadDamageMassThreshold=10.0
    TreadDamageRadius=60.0
    TreadDamageMax=100.0

    BlurTime=3.0
    ShakeRotTime=1.0
    ShakeScale=1.0
}
