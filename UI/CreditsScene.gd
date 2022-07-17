extends Node2D


onready var back_button = $BackButton
onready var animation_p = $AnimationPlayer

func _ready():
	back_button.connect("back_pressed", self, "_on_back_pressed")

func _on_back_pressed():
	animation_p.play("Back")


func get_back():
	get_tree().change_scene("res://MainMenu.tscn")
