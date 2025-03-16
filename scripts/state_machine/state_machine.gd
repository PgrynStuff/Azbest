class_name StateMachine
extends Node

@export var current_state : State
var states: Dictionary[StringName, State] = {}

func _ready() -> void:
	for child in get_children():
		assert(child == State)
		states[child.name] = child
		child.transition.connect(on_child_transition)
		
	current_state.enter()

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func on_child_transition(state_name: StringName) -> void:
	var new_state : State = states[state_name]
	assert(new_state)
	
	if new_state != current_state:
		current_state.exit()
		current_state = new_state
		current_state.enter()
