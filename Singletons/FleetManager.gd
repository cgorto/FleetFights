extends Node
#Fleet Attributes
var max_capacity = 10
var current_capacity = 0
var ships: Array[Ship] = []

signal ship_added(ship)
signal ship_removed(ship)


func add_ship(ship: Ship) -> bool:
	if current_capacity + ship.fleet_usage <= max_capacity:
		current_capacity += ship.fleet_usage
		ships.append(ship)
		emit_signal("ship_added", ship)
		return true
	return false

func remove_ship(ship: Ship) -> bool:
	if ships.has(ship):
		current_capacity -= ship.fleet_usage
		ships.erase(ship)
		emit_signal("ship_removed", ship)
		return true
	return false


