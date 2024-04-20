extends CharacterBody2D
class_name Ship

#Ship Attributes
var ship_name: String = "Unnamed"
var fleet_usage: int = 1
var max_items: int = 1
var icon : Texture2D = load("res://Icons/ship_A.png")
var sprite: Sprite2D
var effect: PackedScene

var base_stats: Dictionary = {
	"health": 100,
	"speed": 10.0

}

@onready var stats: Dictionary = base_stats.duplicate()

signal update_synergy(synergy: Synergy)

var equipped_items: Array = []
var synergy_effects: Dictionary = {}

var sprite_lerp:float = 5

func _physics_process(delta) -> void:
	var fleet_velocity:Vector2 = get_parent().velocity
	var target_velocity:Vector2 = fleet_velocity if fleet_velocity.length() > velocity.length() else velocity
	if target_velocity != Vector2.ZERO:
		sprite.rotation = lerp_angle(sprite.rotation, atan2(target_velocity.x,-target_velocity.y), sprite_lerp * delta)



func _init( _name: String = "Ship", 
			_icon: Texture2D = load("res://Icons/ship_A.png"), 
			_stats: Dictionary = base_stats, 
			_max_items: int = 1, 
			_effect: PackedScene = null) -> void:
	ship_name = _name
	icon = _icon
	stats = _stats
	max_items = _max_items
	var _sprite:Sprite2D = Sprite2D.new()
	_sprite.texture = icon
	_sprite.centered = true
	add_child(_sprite)
	sprite = _sprite
	effect = _effect
	if effect:
		var effect_instance:Node = effect.instantiate()
		add_child(effect_instance)
		
func get_detail(_name: String) -> String:
	match _name:
		"health":
			return str(stats["health"])
		"speed":
			return str(stats["speed"])
		_:
			return ""

