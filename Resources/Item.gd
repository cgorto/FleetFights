extends Node
class_name Item

@export var itemID : String
@export var icon : Texture2D
@export var Name : String
@export var rarity: ItemRarity = ItemRarity.Common
@export var synergy: Synergy = null

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

func _init(_name: String, _icon: Texture2D, _rarity: ItemRarity = ItemRarity.Common, _synergy: Synergy = null):
	name = _name
	icon = _icon
	rarity = _rarity
	synergy = _synergy