extends CharacterBody2D
class_name Ship

#Ship Attributes
var ship_name: String = "Unnamed"
var fleet_usage: int = 1
var max_items: int = 1
var icon : Texture2D = load("res://Icons/ship_A.png")
var sprite: Sprite2D

var base_stats: Dictionary = {
	"health": 100,
	"speed": 10.0

}

@onready var stats = base_stats.duplicate()

var equipped_items: Array = []
var synergies: Array = []

var sprite_lerp = 5

func _physics_process(delta):
	var fleet_velocity = get_parent().velocity
	var target_velocity = fleet_velocity if fleet_velocity.length() > velocity.length() else velocity
	if target_velocity != Vector2.ZERO:
		sprite.rotation = lerp_angle(sprite.rotation, atan2(target_velocity.x,-target_velocity.y), sprite_lerp * delta)



func _init( _name: String = "Ship", _icon: Texture2D = load("res://Icons/ship_A.png"), _stats: Dictionary = base_stats, _max_items: int = 1):
	ship_name = _name
	icon = _icon
	stats = _stats
	max_items = _max_items
	var _sprite = Sprite2D.new()
	_sprite.texture = icon
	_sprite.centered = true
	add_child(_sprite)
	sprite = _sprite

	

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


func _on_aggro(target: Node2D) -> void:
	get_tree().call_group("InFleet", "aggro", target)


############## BOID ##############

var separation_distance = 50.0
var neighborhood_radius = 100.0

var s_coef = 1.5
var a_coef = 1.0
var c_coef = 1.0
var bound = 200

func separation() -> Vector2:
	var steer = Vector2.ZERO
	var count = 0
	for other in get_tree().get_nodes_in_group("InFleet"):
		if other != self:
			var d = position.distance_to(other.position)
			if d < separation_distance:
				steer += position - other.position
				count += 1
	if count > 0:
		steer /= count
	return steer.normalized()

func alignment() -> Vector2:
	var sum = Vector2.ZERO
	var count = 0
	for other in get_tree().get_nodes_in_group("InFleet"):
		if other != self and position.distance_to(other.position) < neighborhood_radius:
			sum += other.velocity
			count += 1
	if count > 0:
		sum /= count
	var local_alignment = sum.normalized()
	var fleet_alignment = get_parent().velocity
	return (local_alignment + fleet_alignment) * 0.5

func cohesion() -> Vector2:
	var sum = Vector2.ZERO
	var count = 0
	for other in get_tree().get_nodes_in_group("InFleet"):
		if other != self and position.distance_to(other.position) < neighborhood_radius:
			sum += other.position
			count += 1
	if count > 0:
		return ((sum / count) - position).normalized()
	return Vector2.ZERO
	
func keep_bounds():
	pass


func calculate_boid_steering() -> void:
	var sep = separation() * s_coef
	var ali = alignment() * a_coef
	var coh = cohesion() * c_coef
	velocity += sep + ali + coh
	velocity = velocity.clamp(Vector2( -stats["speed"], -stats["speed"]), Vector2( stats["speed"], stats["speed"]))
