extends Node2D


var DiceCharacter = preload("res://DiceCharacters/DiceCharacter.tscn")

onready var start_position = $KeyPositions/StartPosition
onready var center_position = $KeyPositions/CenterPosition
onready var end_position = $KeyPositions/EndPosition
onready var dices = $Dices
onready var timer = $Timer
onready var time_label = $Time/Control/TimeLabel
onready var goal = $Goal
onready var animation_player = $AnimationPlayer
onready var player_chatbox = $Chatboxes/PlayerChatBox
onready var tween_in = $Tweens/TweenIn
onready var tween_out = $Tweens/TweenOut
onready var characters_left = $CharactersLeft


onready var current_character = $Dices/CurrentDice
onready var next_character = null

export (bool) var dialogue_on = false

onready var current_amount = 1
onready var amount_of_ch : int = 0

var current_obj : Objective

func instantiate_new_dice():
	var new_dice = DiceCharacter.instance()
	dices.add_child(new_dice)
	new_dice.global_position = start_position.global_position
	new_dice.rest_slots()
	return new_dice

func _ready():
	reset_player_stats()
	current_obj = PlayerInfo.current_objective
	amount_of_ch = PlayerInfo.amount
	set_goal_values()
	center_current_dice()
	update_amount_label()
	
	
func update_amount_label():
	characters_left.label.text = str(PlayerInfo.amount - current_amount)
	if (PlayerInfo.amount - current_amount) <= 0:
		animation_player.play("ShakeAmount")
	
	
func reset_player_stats():
	PlayerInfo.current_heart_matches = 0
	PlayerInfo.current_friend_matches = 0
	PlayerInfo.current_wrong_matches = 0
	
	
func get_back_to_main_menu():
	get_tree().change_scene("res://MainMenu.tscn")

func set_goal_values():
	var h = PlayerInfo.heart_obj - PlayerInfo.current_heart_matches
	var f = PlayerInfo.friend_obj - PlayerInfo.current_friend_matches
	var w = PlayerInfo.wrong_obj - PlayerInfo.current_wrong_matches
	
	goal.set_amounts(h, f, w)
	
func _process(_delta):
	if timer != null:
		time_label.text = str(int(get_timer_current_time()))
	
	if Input.is_action_just_pressed("ui_cancel"):
		animation_player.play("BackToMainMenu")
		
func pop_message():
	animation_player.play("PopPlayerMessage")
	dialogue_on = true
	
func switch_character():
	move_away_current_dice()
	
func center_current_dice():
	tween_in.interpolate_property(current_character, "global_position", start_position.global_position, center_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#current_character.rest_slots()
	current_character.connect("emotions_matched", self, "_on_emotions_match")
	current_character.connect("emotions_matched", goal, "_on_emotions_match")

	tween_in.start()
	
func _on_TweenIn_tween_completed(_object, _key):
	current_amount += 1
	update_amount_label()
	next_character = instantiate_new_dice()
	timer.start()
	
func move_away_current_dice():
	current_character.disconnect("emotions_matched", self, "_on_emotions_match")
	current_character.disconnect("emotions_matched", goal, "_on_emotions_match")
	if dialogue_on:
		animation_player.play("HidePlayerMessage")
	timer.stop()
	tween_out.interpolate_property(current_character, "global_position", center_position.global_position, end_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_out.start()

func _on_TweenOut_tween_completed(_object, _key):
	animation_player.play("MoveAmount")
	current_character.rest_slots()
	current_character = next_character
	if current_amount >= amount_of_ch:
		pass
	else:
		center_current_dice()
	
func get_timer_current_time():
	return timer.time_left
	
func _on_Timer_timeout():
	move_away_current_dice()

func _on_emotions_match( match_value ):
	switch_character()
	set_goal_values()


func _on_TalkButton_button_pressed( _type ):
	player_chatbox.display_text()
	pop_message()
	PlayerInfo.action = "talk"
	current_character.perform_change()


func _on_FlirtButton_button_pressed( _type ):
	player_chatbox.display_text()
	pop_message()
	PlayerInfo.action = "flirt"
	current_character.perform_change()
	

func _on_SmileyButton_button_pressed( _type ):
	player_chatbox.display_smiley()
	pop_message()
	PlayerInfo.action = "smiley"
	current_character.perform_change()
	


func _on_SadFaceButton_button_pressed( _type ):
	player_chatbox.display_sadface()
	pop_message()
	PlayerInfo.action = "sadface"
	current_character.perform_change()
	


func _on_MentionButton_mention_pressed( topic):
	if topic != null:
		pop_message()
		PlayerInfo.action = "mention" + str(topic)
		current_character.perform_change()
		
	


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
