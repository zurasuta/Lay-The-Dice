extends Node2D


var DiceCharacter = preload("res://DiceCharacter.tscn")

onready var start_position = $KeyPositions/StartPosition
onready var center_position = $KeyPositions/CenterPosition
onready var end_position = $KeyPositions/EndPosition
onready var dices = $Dices

onready var tween_in = $Tweens/TweenIn
onready var tween_out = $Tweens/TweenOut


onready var current_character = $Dices/CurrentDice
onready var next_character = null

func instantiate_new_dice():
	var new_dice = DiceCharacter.instance()
	dices.add_child(new_dice)
	new_dice.global_position = start_position.global_position
	return new_dice


func _on_Timer_timeout():
	move_away_current_dice()
#	print("timer out, next character going in")
	pass
	
func _ready():
	center_current_dice()

func center_current_dice():
	tween_in.interpolate_property(current_character, "global_position", start_position.global_position, center_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween_in.start()
	
	
func _on_TweenIn_tween_completed(object, key):
	next_character = instantiate_new_dice()
	
	
func move_away_current_dice():
	tween_out.interpolate_property(current_character, "global_position", center_position.global_position, end_position.global_position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_out.start()


func _on_TweenOut_tween_completed(object, key):
	current_character = next_character
	center_current_dice()
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("boop")
		center_current_dice()
