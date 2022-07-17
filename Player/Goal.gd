extends Node2D

onready var animation_player = $AnimationPlayer
onready var heart_sound = $HeartSound

func _on_emotions_match( emotion ):
	match emotion:
		1:
			heart_sound.play()
			animation_player.play("HeartAnimation")
		2:
			animation_player.play("SmileyAnimation")
		3:
			animation_player.play("WrongAnimation")
