extends Node2D


onready var animation_p = $AnimationPlayer
onready var objectives_manager = $ObjectiveManager

onready var objective_buttons = $ObjectifButtons
onready var objective_button1 = $ObjectifButtons/ObjectifButton
onready var objective_button2 = $ObjectifButtons/ObjectifButton2
onready var objective_button3 = $ObjectifButtons/ObjectifButton3

var easy_objective : Objective 
var medium_objective : Objective
var hard_objective : Objective


func _ready():
	objectives_manager.spawn_new_objective_group()
	update_all_buttons()


func update_all_buttons():
	update_button(objective_button1, easy_objective)
	update_button(objective_button2, medium_objective)
	update_button(objective_button3, hard_objective)

func update_button( b, obj ):
	var button : ObjectifButton = b
	button.set_display(button.objective_display1, "heart", obj.hearts_match_target)
	button.set_display(button.objective_display2, "friend", obj.friends_match_target)
	button.set_display(button.objective_display3, "wrong", obj.wrong_match_target)
	button.set_display(button.amount_display, "amount", obj.amount_of_characters)
	button.objective_grabbed = obj


func change_to_play_scene():
	get_tree().change_scene("res://World.tscn")

func _on_BackButton_back_pressed():
	animation_p.play("Back")

func get_back():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_ObjectiveManager_objective_created(difficulty, objective):
	match difficulty:
		ObjectiveManager.Diff.Easy:
			easy_objective = objective
			
		ObjectiveManager.Diff.Medium:
			medium_objective = objective
			
		ObjectiveManager.Diff.Hard:
			hard_objective = objective



func update_player_info(obj):
	PlayerInfo.heart_obj = obj.hearts_match_target
	PlayerInfo.friend_obj = obj.friends_match_target
	PlayerInfo.wrong_obj = obj.wrong_match_target
	PlayerInfo.amount = obj.amount_of_characters
	

func _on_ObjectifButton_objectif_pressed(obj):
	update_player_info(obj)
	animation_p.play("TransitionToPlay")
	print("pressed button 1")


func _on_ObjectifButton2_objectif_pressed(obj):
	update_player_info(obj)
	
	animation_p.play("TransitionToPlay")
	print("pressed button 2")


func _on_ObjectifButton3_objectif_pressed(obj):
	update_player_info(obj)
	animation_p.play("TransitionToPlay")
	print("pressed button 3")
	
