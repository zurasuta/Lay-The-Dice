extends Node

export (int, 0, 100) var indifference_chance
export (int, 0, 100) var love_chance
export (int, 0, 100) var friend_chance
export (int, 0, 100) var wrong_chance

onready var weight_dictionary = {
	"indifference" : indifference_chance,
	"love" : love_chance,
	"friend" : friend_chance,
	"wrong" : wrong_chance
}

onready var rng = RandomNumberGenerator.new()

func get_total_chance():
	return indifference_chance + love_chance + friend_chance + wrong_chance

func get_random_next_state():
	rng.randomize()
	var total = get_total_chance()
	var r = rng.randi_range(1, total)
	
	for i in weight_dictionary.values().size():
		r -= weight_dictionary.values()[i]
		if r <= 0 :
			return weight_dictionary.keys()[i]

func get_percentage_value( key ):
	var total = get_total_chance()
	return int ( weight_dictionary.get(key) * 100 / total )
