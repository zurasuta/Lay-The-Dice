extends Area2D

export var displacement_amount = 10
onready var button_pressed = $ButtonPressed
onready var button_default = $ButtonDefault
onready var shape = $CollisionShape2D
onready var label = $Label

func _ready():
	pass # Replace with function body.



func _on_MenuButton_mouse_entered():
	button_default.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_MenuButton_mouse_exited():
	button_default.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)



func _physics_process(_delta):
	if Input.is_action_just_pressed("mouse_click"):
		label.rect_position.y += displacement_amount
		button_default.visible = false
	
	if Input.is_action_just_released("mouse_click"):
		label.rect_position.y -= displacement_amount
		button_default.visible = true
