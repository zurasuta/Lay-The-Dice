extends Area2D

class_name CustomOutlineButton

enum ButtonType { Talk, Flirt, Mention, Smiley, Sadface }

export (ButtonType) var button_type
onready var sprite = $Sprite
onready var shape = $CollisionShape2D
onready var topic_slot = $TopicSlot
onready var label = $Label

onready var topic = null

signal button_pressed
signal mention_pressed

func _ready():
	label.text = ButtonType.keys()[button_type]
	
func _on_Button_mouse_entered():
	sprite.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	

func _on_Button_mouse_exited():
	sprite.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_2DOutlineButton_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		if button_type == ButtonType.Mention:
			emit_signal("mention_pressed", topic)
			print("pressed ", ButtonType.keys()[button_type], " : ", str(topic))
		else:
			print("pressed ", ButtonType.keys()[button_type])
			emit_signal("button_pressed", button_type)
		
