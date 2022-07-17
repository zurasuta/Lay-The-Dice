extends Node2D


var DiceCharacter = preload("res://DiceCharacters/DiceCharacter.tscn")

export (int) var easy_time = 60
export (int) var medium_time = 40
export (int) var hard_time = 30

onready var d2 = preload("res://DiceCharacters/ScriptedCharacter/D2.tscn")
onready var d4 = preload("res://DiceCharacters/ScriptedCharacter/D4.tscn")
onready var d8 = preload("res://DiceCharacters/ScriptedCharacter/D8.tscn")
onready var d10 = preload("res://DiceCharacters/ScriptedCharacter/D10.tscn")
onready var d20 = preload("res://DiceCharacters/ScriptedCharacter/D20.tscn")

export (int, 1, 10) var chance_to_get_scripted = 5

onready var scripted_characters = [ d2, d4, d8, d10, d20 ]

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

onready var talk_button = $Buttons/TalkButton
onready var flirt_button = $Buttons/FlirtButton

onready var current_character = $Dices/CurrentDice
onready var next_character = null

onready var rng = RandomNumberGenerator.new()

export (bool) var dialogue_on = false

onready var current_amount = 0
onready var amount_of_ch : int = 0

var current_obj : Objective

func instantiate_new_dice():
	var new_dice 
	rng.randomize()
	if (rng.randi_range(1, 10) < chance_to_get_scripted ):
		rng.randomize()
		scripted_characters.shuffle()
		new_dice = scripted_characters[0].instance()
	else:
		new_dice = DiceCharacter.instance()
	
	
	dices.add_child(new_dice)
	new_dice.global_position = start_position.global_position
	new_dice.rest_slots()
	return new_dice


func set_timer_value():
	match PlayerInfo.difficulty:
		"Easy":
			timer.wait_time = easy_time + 0.5
			
		"Medium":
			timer.wait_time = medium_time + 0.5
			
		"Hard":
			timer.wait_time = hard_time + 0.5
			
		
func _ready():
	set_timer_value()
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
		PlayerInfo.mainmenu_stream.play()
		
	
		
func pop_message():
	animation_player.play("PopPlayerMessage")
	dialogue_on = true
	
func switch_character():
	move_away_current_dice()
	
func center_current_dice():
	
	current_character.music_stream.play()
	current_character.connect("emotions_matched", self, "_on_emotions_match")
	current_character.connect("emotions_matched", goal, "_on_emotions_match")
	tween_in.interpolate_property(current_character, "global_position", start_position.global_position, center_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#current_character.rest_slots()
	tween_in.interpolate_property(current_character.music_stream, "volume_db", current_character.music_stream.volume_db, -20, 1.5)
	tween_in.start()
	next_character = instantiate_new_dice()
	
func _on_TweenIn_tween_completed(_object, _key):

	talk_button.update_percentage_group(current_character)
	flirt_button.update_percentage_group(current_character)
	current_character.music_stream.play()
	time_label.visible = true
	timer.start()
	update_amount_label()
	
func move_away_current_dice():
	current_character.disconnect("emotions_matched", self, "_on_emotions_match")
	current_character.disconnect("emotions_matched", goal, "_on_emotions_match")
	if dialogue_on:
		animation_player.play("HidePlayerMessage")
	timer.stop()
	tween_out.interpolate_property(current_character, "global_position", center_position.global_position, end_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_out.interpolate_property(current_character.music_stream, "volume_db", -20, -80, 0.5)
	tween_out.start()
	animation_player.play("MoveAmount")
	current_character.rest_slots()
	current_character = next_character
	if current_amount >= amount_of_ch:
		pass
	else:
		current_amount += 1
		update_amount_label()
		center_current_dice()

func _on_TweenOut_tween_completed(_object, _key):
	current_character.music_stream.stop()

	
func get_timer_current_time():
	return timer.time_left
	
func _on_Timer_timeout():
	move_away_current_dice()

func _on_emotions_match( match_value ):
	current_amount -= 1
	switch_character()
	set_goal_values()
	timer.stop()


func _on_TalkButton_button_pressed( _type ):
	player_chatbox.display_text()
	pop_message()
	PlayerInfo.action = "talk"
	current_character.perform_change(PlayerInfo.action)
	talk_button.update_percentage_group(current_character)
	flirt_button.update_percentage_group(current_character)
	
func _on_FlirtButton_button_pressed( _type ):
	player_chatbox.display_text()
	pop_message()
	PlayerInfo.action = "flirt"
	current_character.perform_change(PlayerInfo.action)
	talk_button.update_percentage_group(current_character)	
	flirt_button.update_percentage_group(current_character)	

func _on_SmileyButton_button_pressed( _type ):
	player_chatbox.display_smiley()
	pop_message()
	PlayerInfo.action = "smiley"
	current_character.perform_change(PlayerInfo.action)
	talk_button.update_percentage_group(current_character)	
	flirt_button.update_percentage_group(current_character)

func _on_SadFaceButton_button_pressed( _type ):
	player_chatbox.display_sadface()
	pop_message()
	PlayerInfo.action = "sadface"
	current_character.perform_change(PlayerInfo.action)
	talk_button.update_percentage_group(current_character)
	flirt_button.update_percentage_group(current_character)	


func _on_MentionButton_mention_pressed( topic):
	if topic != null:
		pop_message()
		PlayerInfo.action = "mention" + str(topic)
		current_character.perform_change(PlayerInfo.action)
		
	


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
