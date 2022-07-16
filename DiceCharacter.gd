extends Node2D


signal state_changed

enum { Idle, Angry, Sad, Happy, Love }

export (String) var character_name = "DefaultName"
export (Color) var character_color

onready var slots = $EmotionSlots
onready var state = Idle setget set_state

func set_state(value):
	state = value
	emit_signal("state_changed")

func _ready():
	pass
