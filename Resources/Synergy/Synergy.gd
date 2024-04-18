extends Node
class_name Synergy

var synergy_name: String
var breakpoints: Array[int] = []
var effects: Dictionary = {} #breakpoints to effects (int to packed scene)

func _init(_name: String, _breakpoints: Array[int], _effects: Dictionary):
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

#UHHH be careful?? groups might be global??? so if there are issues, change the names of the groups in FleetManager.gd or here
#I am also adding ships to a group on the fleet to keep track. This might interfere with that! vvv

## Adds synergy effects to a target node based on the count, also adds effects to group of synergy name
func add_effects(target: Node, count: int = 0) -> void:
    for effect in get_effects(count):
        var effect_instance = effect.instantiate()
        target.add_child(effect_instance)
        target.add_to_group(synergy_name, effect_instance)

## Remove synergy effects from a target node based on the count
func remove_effects(target: Node, count: int = 0) -> void:
    var effects_to_keep = get_effects(count)
    for effect in target.get_nodes_in_group(synergy_name):
        if effect not in effects_to_keep: #This might not work since array is of packed scene and effect is node, but principle is the same
            effect.queue_free()
            
func update_effects(target: Node, count: int = 0) -> void:
    var new_effects = get_effects(count)
    get_tree().call_group(synergy_name, "queue_free")
