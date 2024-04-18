extends Resource
class_name Synergy

@export var synergy_name: String
@export var breakpoints: Array[int] = []
@export var effects: Dictionary = {} #breakpoints to effects (int to packed scene)

func _init(_name: String = "", _breakpoints: Array[int] = [], _effects: Dictionary = {}) -> void:
	synergy_name = _name
	breakpoints = _breakpoints
	effects = _effects

## Returns a list of effects that should be active based on the count
func get_effects(count: int = 0) -> Array[PackedScene]:
	var effect_list = []
	for i in breakpoints:
		if count >= i:
			effect_list.append(effects[i])
	return effect_list

func apply_effects(target: Ship, count: int = 0) -> void:
	var current_effects = target.synergy_effects.get(synergy_name, [])
	var new_effects = get_effects(count)
	var effects_to_remove = current_effects.difference(new_effects)
	var effects_to_add = new_effects.difference(current_effects)

	for effect_instance in effects_to_remove:
		effect_instance.queue_free()
		target.synergy_effects[synergy_name].erase(effect_instance)

	for effect in effects_to_add:
		var effect_instance = effect.instantiate()
		target.add_child(effect_instance)
		target.synergy_effects[synergy_name].append(effect_instance)

	if new_effects.size() == 0:
		target.remove_from_group(synergy_name)
	else:
		target.add_to_group(synergy_name)

	
