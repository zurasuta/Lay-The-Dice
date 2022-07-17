extends Node

onready var objective_resource = preload("res://Objectives/ObjectiveResource.gd")

onready var tokens = 0

onready var current_heart_matches = 0 
onready var current_friend_matches = 0 
onready var current_wrong_matches = 0 

onready var amount = 0
onready var heart_obj = 0 
onready var friend_obj = 0 
onready var wrong_obj = 0 

onready var current_objective = null setget set_obj

onready var action = null

func set_obj(value):
	current_objective = value
	heart_obj = value.hearts_match_target
	
