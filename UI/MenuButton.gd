extends Area2D


enum MenuButtonType { Play, Credits, Settings, Exit, Back, Objectif }
export (MenuButtonType) var button_type 
export var displacement_amount = 10

signal play_pressed
signal credits_pressed
signal settings_pressed
signal exit_pressed
signal back_pressed

onready var button_pressed = $ButtonPressed
onready var button_default = $ButtonDefault
onready var shape = $CollisionShape2D
onready var label = $Label

onready var mouse_on = false

func _ready():
	pass # Replace with function body.

func choose_signal_to_emit():
	match button_type:
		MenuButtonType.Play:
			emit_signal("play_pressed")
		MenuButtonType.Credits:
			emit_signal("credits_pressed")
		MenuButtonType.Settings:
			emit_signal("settings_pressed")
		MenuButtonType.Exit:
			emit_signal("exit_pressed")
		MenuButtonType.Back:
			emit_signal("back_pressed")

func _on_MenuButton_mouse_entered():
	mouse_on = true
	button_default.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_MenuButton_mouse_exited():
	mouse_on = false
	button_default.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _physics_process(_delta):
	if Input.is_action_just_pressed("mouse_click") && mouse_on:
		label.rect_position.y += displacement_amount
		button_pressed.visible = true
		button_default.visible = false
		
	
	if Input.is_action_just_released("mouse_click") && mouse_on:
		PlayerInfo.audio_stream.play()
		choose_signal_to_emit()
		label.rect_position.y -= displacement_amount
		button_pressed.visible = false
		button_default.visible = true
