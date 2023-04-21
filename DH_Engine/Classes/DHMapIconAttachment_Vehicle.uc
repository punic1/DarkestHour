//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2023
//==============================================================================

class DHMapIconAttachment_Vehicle extends DHMapIconAttachment
    notplaceable;

// TODO:
//   - Implement ownership for all vehicles (i.e. locking system), and update
//     squad index based on the current owner insted of the driver.
//   - Update status when player switches squads while in the vehicle.
function UpdateOccupancyStatus(DHVehicle Vehicle)
{
    local DHPlayerReplicationInfo PRI;

    if (Vehicle == none)
    {
        return;
    }

    // Vehicle is not occupied
    // TODO: Check for weapon positions
    if (Vehicle.Controller == none)
    {
        Tag = 254;
        return;
    }

    PRI = DHPlayerReplicationInfo(Vehicle.Controller.PlayerReplicationInfo);

    if (PRI != none)
    {
        Tag = PRI.SquadIndex;
    }
}

function EVisibleFor GetVisibility()
{
    return VISIBLE_Team;
}

function EVisibleFor GetVisibilityInDangerZone()
{
    return VISIBLE_Enemy;
}

simulated function Material GetIconMaterial(DHPlayer PC)
{
    local Material RotatedMaterial;

    if (PC != none)
    {
        RotatedMaterial = default.IconMaterial;
        TexRotator(RotatedMaterial).Rotation.Yaw = GetMapIconYaw(DHGameReplicationInfo(PC.GameReplicationInfo));
        return RotatedMaterial;
    }
}

// TODO: Refactor this!
simulated function color GetIconColor(DHPlayer PC)
{
    local byte PlayerTeamIndex, IconTeamIndex;

    IconTeamIndex = GetTeamIndex();

    if (PC != none)
    {
        PlayerTeamIndex = PC.GetTeamNum();

        if (PlayerTeamIndex > 1)
        {
            if (IconTeamIndex < arraycount(class'DHColor'.default.TeamColors))
            {
                return class'DHColor'.default.TeamColors[IconTeamIndex];
            }
        }
        else if (IconTeamIndex < 2)
        {
            if (PlayerTeamIndex != IconTeamIndex)
            {
                return class'UColor'.default.Red;
            }
            else if (Tag == 254)
            {
                return class'UColor'.default.Gray;
            }
            else if (PC.GetSquadIndex() == Tag)
            {
                return class'DHColor'.default.SquadColor;
            }
        }
    }

    return class'DHColor'.default.FriendlyColor;
}

defaultproperties
{
    bTrackMovement=true
    IconMaterial=TexRotator'DH_InterfaceArt2_tex.Icons.truck_topdown_rot'
    IconScale=0.035
    Tag=254 // vehicle is empty
}
