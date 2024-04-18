extends Node

var ship_inventory: Array[Ship] = []
var item_inventory: Array[Item] = []

signal item_added(item)
signal item_removed(item)
signal item_equipped(item)
signal item_unequipped(item)

signal ship_added(ship)
signal ship_removed(ship)
signal ship_equipped(ship)
signal ship_unequipped(ship)


func _ready():
	set_physics_process(false)

