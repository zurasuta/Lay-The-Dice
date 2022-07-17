extends Node2D

class_name ObjectiveDisplay 

onready var emotion_target_sprite = $EmotionTarget
onready var amount_target_label = $AmountTarget

func set_sprite( string ):
	match string:
		"heart":
			emotion_target_sprite.frame = 1
		"friend":
			emotion_target_sprite.frame = 2
		"wrong":
			emotion_target_sprite.frame = 3
		"amount":
			emotion_target_sprite.frame = 5

func set_amount( value ):
	amount_target_label.text = str( value )
	if value == 0:
		visible = false
	else:
		visible = true
