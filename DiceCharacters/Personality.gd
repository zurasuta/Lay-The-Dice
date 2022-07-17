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
	current_state = state
	print(state)
	return state
	
func get_initial_state():
	
	match initial_state:
		
		State.Indifferent:
			current_state = $StateSet/IndifferentState
			return $StateSet/IndifferentState
			
		State.Love:
			current_state = $StateSet/LoveState
			return $StateSet/LoveState
		
		State.Friendly:
			current_state = $StateSet/FriendlyState
			return $StateSet/FriendlyState
			
		State.Wrong:
			current_state = $StateSet/WrongState
			return $StateSet/WrongState


		
func randomize_myself():
	print(PlayerInfo.difficulty)
	
	match PlayerInfo.difficulty:
		"Easy":
			adjust_chains( 1/3, 2, 1.5, 2/3 )

		"Medium":
			adjust_chains( 1, 2, 1.5, 1 )
			
		"Hard":
			adjust_chains( 1, 1.2, 1.5,  1.5 )

func adjust_chains( indifference_factor, love_factor, friend_factor, wrong_factor):
	for i in state_set.get_children():
		for j in i.get_children():
			if j is MarkovNode:
				var node : MarkovNode = j
				node.indifference_chance = node.indifference_chance * indifference_factor
				node.love_chance = node.love_chance * love_factor
				node.friend_chance = node.friend_chance * friend_factor
				node.wrong_chance = 2 * node.wrong_chance * wrong_factor
