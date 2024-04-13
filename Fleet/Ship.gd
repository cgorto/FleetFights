extends CharacterBody2D
class_name Ship

#Ship Attributes
var ship_name: String = "Unnamed"
var fleet_usage: int = 1
var max_items: int = 1
var icon : Texture2D = load("res://Icons/ship_A.png")

var base_stats: Dictionary = {
	"health": 100,
	"speed": 10.0

}

@onready var stats = base_stats.duplicate()

var equipped_items: Array = []
var synergies: Array = []

func _init( _name: String = "Ship", _icon: Texture2D = load("res://Icons/ship_A.png"), _stats: Dictionary = base_stats, _max_items: int = 1):
	ship_name = _name
	icon = _icon
	stats = _stats
	max_items = _max_items
	


func equip_item(item) -> bool:
	if equipped_items.size() < max_items:
		equipped_items.append(item)
		modify_stats(item.stats)
		return true
	return false

func unequip_item(item) -> bool:
	if equipped_items.has(item):
		equipped_items.erase(item)
		var negative_stats = base_stats.duplicate()
		for stat in item.stats.keys():
			negative_stats[stat] -= item.stats[stat]
		modify_stats(negative_stats)
		return true
	return false

func modify_stats(_stats: Dictionary) -> void:
	for key in _stats.keys():
		self.stats[key] += _stats[key]

func get_detail(_name: String) -> String:
	match _name:
		"health":
			return str(stats["health"])
		"speed":
			return str(stats["speed"])
		_:
			return ""


