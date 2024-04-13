extends Node
class_name Item

@export var ItemID : String
@export var Icon : Texture2D
@export var Name : String
@export var Rarity: ItemRarity = ItemRarity.Common
@export var Synergy = 0 #change this

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