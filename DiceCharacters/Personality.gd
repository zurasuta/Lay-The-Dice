extends Node

enum State { Indifferent, Love, Friendly, Wrong }

export (State) var initial_state

onready var opinion_set = $OpinionSet
onready var state_set = $StateSet

var current_state

func set_state_as_active( state ):
	for s in state_set.get_children():
		if s != state:
			s.active_state = false
		else:
			s.active_state = true
	
	print(state)
	return state
	
func get_initial_state():
	
	match initial_state:
		
		State.Indifferent:
			return $StateSet/IndifferentState
			
		State.Love:
			return $StateSet/LoveState
		
		State.Friendly:
			return $StateSet/FriendlyState
			
		State.Wrong:
			return $StateSet/WrongState


		
