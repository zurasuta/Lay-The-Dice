extends Node

enum Diff { Easy, Medium, Hard }

onready var rng = RandomNumberGenerator.new()
onready var ObjectiveScene = preload("res://Player/Objective.tscn")

onready var easy_stats = $EasyStats
onready var medium_stat = $MediumStats
onready var hard_stats = $HardStats
onready var objectives_group = $ObjectivesGroup

onready var stats : ObjectiveStats = null

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		spawn_new_objective_group()
	
func spawn_new_objective_group():
	for o in objectives_group.get_children():
		o.queue_free()
	
	create_new_objective(Diff.Easy)
	create_new_objective(Diff.Medium)
	create_new_objective(Diff.Hard)


func create_new_objective( difficulty ) :
	var char_count = 0
	match difficulty:
		Diff.Easy:
			stats = easy_stats
		Diff.Medium:
			stats = medium_stat
		Diff.Hard:
			stats = hard_stats
	
	var new_objective = ObjectiveScene.instance()
	rng.randomize()
	new_objective.difficulty = Diff.keys()[difficulty]
	new_objective.hearts_match_target = rng.randi_range(stats.MIN_HEARTS, stats.MAX_HEARTS)
	char_count += new_objective.hearts_match_target
	
	new_objective.friends_match_target = rng.randi_range(stats.MIN_FRIENDS, stats.MAX_FRIENDS)
	char_count += new_objective.friends_match_target
	
	new_objective.wrong_match_target = rng.randi_range(stats.MIN_WRONGS, stats.MAX_WRONGS)
	char_count += new_objective.wrong_match_target
	new_objective.amount_of_characters = char_count + rng.randi_range(stats.EXTRA_CHARACTER_MIN_AMOUNT, stats.EXTRA_CHARACTER_MAX_AMOUNT)
	
	objectives_group.add_child(new_objective)
	print(new_objective)
	
