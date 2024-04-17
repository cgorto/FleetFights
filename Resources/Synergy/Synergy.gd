extends Node
class_name Synergy

var synergy_name: String
var breakpoints: Array[int] = []
var effects: Dictionary = {} #breakpoints to effects

func _init(_name: String, _breakpoints: Array[int], _effects: Dictionary):
    synergy_name = _name
    breakpoints = _breakpoints
    effects = _effects

func get_effects(count: int = 0) -> Array[PackedScene]:
    var effect_list = []
    for i in breakpoints:
        if count >= i:
            effect_list.append(effects[i])
    return effect_list


func _add_synergies(target: Node2D, count: int = 0) -> void:
    for effect in get_effects(count):
        var effect_instance = effect.instantiate()
        target.add_child(effect_instance)

            
