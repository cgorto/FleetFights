extends Control

@onready var ship_list = $HBoxContainer/ShipListSection/ShipList
@onready var ship_details = $HBoxContainer/DetailsAndItems/DetailsArea/ShipDetails
@onready var item_slots = $HBoxContainer/DetailsAndItems/DetailsArea/ItemSlots

# Called when the node enters the scene tree for the first time.
var icon_dict = {
	1: "res://Icons/ship_A.png",
	2: "res://Icons/ship_B.png",
	3: "res://Icons/ship_C.png",
	4: "res://Icons/ship_D.png",
	5: "res://Icons/ship_E.png",
	6: "res://Icons/ship_F.png",
	7: "res://Icons/ship_G.png",
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_ship_list(ships: Array[Ship]) -> void:
	ship_list.clear()
	for ship in ships:
		ship_list.add_item(ship.ship_name,ship.icon)

func _on_ship_list_item_selected(index):
	var selected_ship = FleetManager.ships[index]
	update_ship_details(selected_ship)

func update_ship_details(ship: Ship) -> void:
	for child in ship_details.get_children():
		if "Label" in child.get_class():
			var detail = ship.get_detail(child.name)
			child.text = detail


func _on_add_ship_pressed():
	#create new instance of ship
	if FleetManager.add_ship(Ship.new("New Ship" + str(randi_range(1,100)), load(icon_dict.get((randi_range(1,7)))), {"health": randf_range(1,100), "speed": randf_range(1,100)})):
		update_ship_list(FleetManager.ships)


func _on_level_pressed():
	get_tree().change_scene_to_file("res://Test/test_levle.tscn")

