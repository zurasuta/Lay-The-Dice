extends Area2D


onready var sprite = $Sprite
onready var shape = $CollisionShape2D


	
func _on_Button_mouse_entered():
	sprite.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	



func _on_Button_mouse_exited():
	sprite.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)




func _on_2DOutlineButton_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		print("click")
