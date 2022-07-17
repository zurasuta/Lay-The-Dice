extends Node


export (bool) var active_state = false setget set_state

export var sounds = [ preload("res://Sound Effects/mocha sounds/noot_noot.wav") ]
export var dialogues = [ "", "", "" ]

signal dialogue_out( dialogue )

onready var talk_markov = $TalkMarkov
onready var flirt_markov = $FlirtMarkov
onready var smiley_markov = $SmileyMarkov
onready var sadface_markov = $SadFaceMarkov

onready var audio = $AudioStreamPlayer

func set_state(value):
	active_state = value

func get_random( array : Array ):
	randomize()
	array.shuffle()
	return array[0]
	
func talk():
	emit_signal("dialogue_out", get_random(dialogues))
	audio.stream = get_random(sounds)
	audio.play()
