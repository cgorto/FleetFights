class_name SynergyComponent extends Node

@export var synergy: Synergy

func _enter_tree() -> void:
    assert(owner is Ship)
    owner.set_meta(synergy.synergy_name, self)

func _exit_tree() -> void:
    owner.remove_meta(synergy.synergy_name)

func update_effect(count: int = 0) -> void:
    var curr_effects: Array[Node] = get_children()
    var new_effects: Array[PackedScene] = synergy.get_effects(count)
    
    for effect in curr_effects:
        effect.queue_free()
    
    if count == 0:
        return

    for effect in new_effects:
        var effect_instance: Node = effect.instantiate()
        add_child(effect_instance)
    