extends Node

onready var objective_resource = preload("res://Objectives/ObjectiveResource.gd")

onready var button_sound = preload("res://Sound Effects/Button Sounds/Button_click_sound.wav")
onready var mainmenu_music = preload("res://Music/Lay_the_Dice.ogg")

onready var audio_stream = AudioStreamPlayer.new()
onready var mainmenu_stream = AudioStreamPlayer.new()

onready var tokens = 0

onready var current_heart_matches = 0 
onready var current_friend_matches = 0 
onready var current_wrong_matches = 0 

onready var amount = 0
onready var heart_obj = 0 
onready var friend_obj = 0 
onready var wrong_obj = 0 

var difficulty

onready var current_objective = null setget set_obj

onready var action = null

func _ready():
	add_child(audio_stream)
	audio_stream.volume_db -= 10
	audio_stream.stream = button_sound
	
	add_child(mainmenu_stream)
	mainmenu_stream.volume_db -= 15
	mainmenu_stream.stream = mainmenu_music
	
	mainmenu_stream.play()


func set_obj(value):
	current_objective = value
	heart_obj = value.hearts_match_target
	
