extends Node2D

onready var animation_player = $AnimationPlayer
onready var heart_sound = $HeartSound
onready var friend_sound = $FriendSound
onready var wrong_sound = $WrongSound

func _on_emotions_match( emotion ):
	match emotion:
		1:
			heart_sound.play()
			animation_player.play("HeartAnimation")
		2:
			friend_sound.play()
			animation_player.play("SmileyAnimation")
		3:
			wrong_sound.play()
			animation_player.play("WrongAnimation")
