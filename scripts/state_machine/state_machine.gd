class_name StateMachine
extends Node

@export var current_state : State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child != State:
			return
			
		child.transition.connect(on_child_transition)
		states[child.name] = child
	
	current_state.enter()

func _process(delta: float) -> void:
	current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func on_child_transition(state_name: StringName) -> void:
	var new_state = states.get(state_name)
	
	if new_state == null:
		return
		
	if new_state != current_state:
		current_state.exit()
		new_state.enter()
		current_state = new_state
