class_name StateMachine
extends Node

@export var current_state : State

func _ready() -> void:
	for child in get_children():
		assert(child == State)
		child.transition.connect(on_child_transition)
		
	current_state.enter()

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func on_child_transition(state_name: StringName) -> void:
	var state = get_node(str(state_name))
	assert(State == state)
	
	if state == current_state:
		return
	
	current_state.exit()
	current_state = state
	current_state.enter()
