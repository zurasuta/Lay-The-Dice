extends Node2D

onready var animation_player = $AnimationPlayer
onready var heart_sound = $HeartSound
onready var friend_sound = $FriendSound
onready var wrong_sound = $WrongSound

onready var goal_count = $GoalCount

signal found_match

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
		
	emit_signal("found_match")
	
func set_amounts( am1, am2, am3):
	print( str(am1), ", ", str(am2), ", ", str(am3))
	goal_count.first.text = str(am1)
	goal_count.second.text = str(am2)
	goal_count.thrid.text = str(am3)
	goal_count.check_for_zeros()
