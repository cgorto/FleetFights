extends Node
class_name Item

@export var itemID : String
@export var icon : Texture2D
@export var item_name : String = ""
@export var rarity: ItemRarity = ItemRarity.Common
@export var synergy: Synergy = null
@export var stats: Dictionary = {}

enum ItemRarity {
	Common,
	Uncommon,
	Rare,
	Epic,
	Legendary
}

enum ItemState {
	Available,
	Equipped,
	Stored
}

func _init(_name: String = "", _icon: Texture2D = null, _rarity: ItemRarity = ItemRarity.Common, _synergy: Synergy = null) -> void:
	item_name = _name
	icon = _icon
	rarity = _rarity
	synergy = _synergy
