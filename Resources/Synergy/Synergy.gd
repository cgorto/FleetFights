class_name Synergy extends Resource

@export var synergy_name: String
@export var breakpoints: Array[int] = []
@export var effects: Dictionary = {} #breakpoints to effects (int to packed scene)

func _init(_name: String = "", _breakpoints: Array[int] = [], _effects: Dictionary = {}) -> void:
	synergy_name = _name
	breakpoints = _breakpoints
	effects = _effects

## Returns a list of effects that should be active based on the count
func get_effects(count: int = 0) -> Array[PackedScene]:
	var effect_list:Array[PackedScene] = []
	for i in breakpoints:
		if count >= i:
			effect_list.append(effects[i])
	return effect_list


	
