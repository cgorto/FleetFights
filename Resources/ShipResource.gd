extends Resource
class_name ShipResource

var ship_name: String
var base_stats: Dictionary
#@onready var modified_stats = base_stats
var equipment: Array[Item] = []
var item_cap: int = 1
var fleet_usage: int = 1
var texture = load("res://Icons/ship_A.png")

func _init(_name: String, _base_stats: Dictionary, _item_cap: int = 1, _fleet_usage: int = 1,):
	ship_name = _name
	base_stats = _base_stats
	fleet_usage = _fleet_usage


