extends Node2D


export (String) var topic_key = "default"
onready var sprite = $Sprite



func _on_Topic_mouse_entered():
	sprite.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)




func _on_Topic_mouse_exited():
	sprite.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
