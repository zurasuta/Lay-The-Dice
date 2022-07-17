extends Node2D

onready var play_button = $PlayButton
onready var credits_button = $CreditsButton
onready var exit_button = $ExitButton
onready var animation_p = $AnimationPlayer
func _ready():
	play_button.connect("play_pressed", self, "_on_play_pressed")
	credits_button.connect("credits_pressed", self, "_on_credits_pressed")
	exit_button.connect("exit_pressed", self, "_on_exit_pressed")

func _on_play_pressed():
	animation_p.play("HideButtonsPlay")

func _on_credits_pressed():
	animation_p.play("HideButtonsCredits")

func _on_exit_pressed():
	get_tree().quit()

func end_hide_animation_for_credits():
	get_tree().change_scene("res://UI/CreditsScene.tscn")

func end_hide_animation_for_play():
	get_tree().change_scene("res://Objectives/ObjectivesScene.tscn")
