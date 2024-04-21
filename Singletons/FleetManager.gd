extends Node
#Fleet Attributes
var max_capacity: int = 10
var current_capacity: int = 0
var ships: Array[Ship] = []



signal ship_added(ship: Ship)
signal ship_removed(ship: Ship)


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



func get_synergies_count(synergy_name: String) -> int:
	var count:int = 0
	for ship in ships:
		if ship.has_meta(synergy_name):
			count += 1
	return count

func update_synergies(synergy_name: String) -> void:
	var count:int = get_synergies_count(synergy_name)
	for ship in ships:
		if ship.has_meta(synergy_name):
			ship.get_synergy(synergy_name).update_effect(count)
