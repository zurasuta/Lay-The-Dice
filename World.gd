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

onready var tween_in = $Tweens/TweenIn
onready var tween_out = $Tweens/TweenOut


onready var current_character = $Dices/CurrentDice
onready var next_character = null


func instantiate_new_dice():
	var new_dice = DiceCharacter.instance()
	dices.add_child(new_dice)
	new_dice.global_position = start_position.global_position
	new_dice.rest_slots()
	return new_dice

func _ready():
	center_current_dice()
	
func _process(_delta):
	if timer != null:
		time_label.text = str(int(get_timer_current_time()))
	
	if Input.is_action_just_pressed("ui_accept"):
		current_character.perform_change()
		current_character.update_slots()
		
func pop_message():
	animation_player.play("PopPlayerMessage")
	
func switch_character():
	move_away_current_dice()
	
func center_current_dice():
	tween_in.interpolate_property(current_character, "global_position", start_position.global_position, center_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#current_character.rest_slots()
	current_character.connect("emotions_matched", self, "_on_emotions_match")
	current_character.connect("emotions_matched", goal, "_on_emotions_match")

	tween_in.start()
	
func _on_TweenIn_tween_completed(_object, _key):
	next_character = instantiate_new_dice()
	timer.start()
	
func move_away_current_dice():
	current_character.disconnect("emotions_matched", self, "_on_emotions_match")
	current_character.disconnect("emotions_matched", goal, "_on_emotions_match")
	timer.stop()
	tween_out.interpolate_property(current_character, "global_position", center_position.global_position, end_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_out.start()

func _on_TweenOut_tween_completed(_object, _key):
	current_character.rest_slots()
	current_character = next_character
	center_current_dice()
	
func get_timer_current_time():
	return timer.time_left
	
func _on_Timer_timeout():
	move_away_current_dice()

func _on_emotions_match( match_value ):
	switch_character()


func _on_TalkButton_button_pressed( _type ):
	pop_message()
	print("talk button pressed")


func _on_FlirtButton_button_pressed( _type ):
	animation_player.play("PopPlayerMessage")
	print("flirt button pressed")


func _on_SmileyButton_button_pressed( _type ):
	animation_player.play("PopPlayerMessage")
	print("smiley button pressed")


func _on_SadFaceButton_button_pressed( _type ):
	animation_player.play("PopPlayerMessage")
	print("sadface button pressed")
