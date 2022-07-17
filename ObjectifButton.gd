extends "res://UI/MenuButton.gd"

class_name ObjectifButton

enum ObjectiveDiff { Easy, Medium, Hard }

export (ObjectiveDiff) var difficulty

var objective_grabbed : Objective

signal objectif_pressed(obj)

onready var display_group = $Label
onready var objective_display1 = $Label/ObjectiveDisplay
onready var objective_display2 = $Label/ObjectiveDisplay2
onready var objective_display3 = $Label/ObjectiveDisplay3
onready var amount_display = $Label/AmountDisplay

func _ready():
	label.text = ObjectiveDiff.keys()[difficulty]

func set_display( display : ObjectiveDisplay, type : String , amount : int ):
	display.set_sprite(type)
	display.set_amount(amount)

func _physics_process(_delta):
	if Input.is_action_just_pressed("mouse_click") && mouse_on:
		label.rect_position.y += displacement_amount
		button_pressed.visible = true
		button_default.visible = false
		
	
	if Input.is_action_just_released("mouse_click") && mouse_on:
		emit_signal("objectif_pressed", objective_grabbed)
		label.rect_position.y -= displacement_amount
		button_pressed.visible = false
		button_default.visible = true
