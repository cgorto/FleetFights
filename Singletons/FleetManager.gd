extends Node
#Fleet Attributes
var max_capacity = 10
var current_capacity = 0
var ships: Array[Ship] = []



signal ship_added(ship)
signal ship_removed(ship)

## Tries to add a ship to the fleet array
func add_ship(ship: Ship) -> bool:
	if current_capacity + ship.fleet_usage <= max_capacity:
		current_capacity += ship.fleet_usage
		ships.append(ship)
		emit_signal("ship_added", ship)
		return true
	return false

## Tries to remove a ship from the fleet array
func remove_ship(ship: Ship) -> bool:
	if ships.has(ship):
		current_capacity -= ship.fleet_usage
		ships.erase(ship)
		emit_signal("ship_removed", ship)
		return true
	return false


#UHHH be careful?? groups might be global??? so if there are issues, change the names of the groups in synergy.gd or here
#I am also adding effects to a group on the ship to keep track.
func get_synergies_count(synergy_name: String) -> int:
	var group = get_tree().get_nodes_in_group(synergy_name)
	return group.size()