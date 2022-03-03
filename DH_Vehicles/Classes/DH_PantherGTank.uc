//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DH_PantherGTank extends DH_PantherDTank;

defaultproperties
{
    VehicleNameString="Panzer V 'Panther' Ausf.G"
    PassengerWeapons(0)=(WeaponPawnClass=class'DH_Vehicles.DH_PantherGCannonPawn')
    FrontArmor(0)=(Thickness=5.0)
    FrontArmor(1)=(Thickness=8.0)
    RightArmor(0)=(Thickness=4.5)
	RightArmor(1)=(Thickness=4.3,MaxRelativeHeight=22.0,LocationName="lower")
    RightArmor(2)=(Thickness=5.0,Slope=29.0)
    LeftArmor(0)=(Thickness=4.5)
	LeftArmor(1)=(Thickness=4.3,MaxRelativeHeight=22.0,LocationName="lower")
    LeftArmor(2)=(Thickness=5.0,Slope=29.0)

    // Damage
	// pros: 5 men crew;
	// cons: petrol fuel; general unreliability of the panthers; this variant is a later one, so partially fixed and improved
    Health=565
    HealthMax=565.0
	EngineHealth=240  //engine health is lowered for above reason (higher than ausf D)

    EngineRestartFailChance=0.25 //unreliability
}
