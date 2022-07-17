extends Node2D


onready var first = $FirstGoal/Label
onready var second = $SecondGoal/Label
onready var thrid = $ThirdGoal/Label

func _ready():
	check_for_zeros()

func check_for_zeros():
	if PlayerInfo.heart_obj <= 0 or (PlayerInfo.current_heart_matches >= PlayerInfo.heart_obj):
		$FirstGoal.visible = false
	else:
		$FirstGoal.visible = true
	
	if PlayerInfo.friend_obj <= 0 or (PlayerInfo.current_friend_matches >= PlayerInfo.friend_obj):
		$SecondGoal.visible = false
	else:
		$SecondGoal.visible = true
	
	if PlayerInfo.wrong_obj <= 0 or (PlayerInfo.current_wrong_matches >= PlayerInfo.wrong_obj):
		$ThirdGoal.visible = false
	else:
		$ThirdGoal.visible = true
		
