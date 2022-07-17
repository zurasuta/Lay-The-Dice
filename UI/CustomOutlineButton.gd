extends Area2D

class_name CustomOutlineButton

enum ButtonType { Talk, Flirt, Mention, Smiley, Sadface }

export (ButtonType) var button_type
onready var sprite = $Sprite
onready var shape = $CollisionShape2D
onready var topic_slot = $TopicSlot
onready var label = $Label
onready var audio = $AudioStreamPlayer
onready var over_audio = $OverAudio

var character : DiceCharacter

onready var label1 = $PercentageGroup/Icon1/Label2
onready var label2 = $PercentageGroup/Icon2/Label3

onready var topic = null

signal button_pressed
signal mention_pressed

func _ready():
	label.text = ButtonType.keys()[button_type]
	
func update_percentage_group( _character ):
	character = _character
	var p_state = character.current_pstate
	
	match button_type:
		ButtonType.Talk:
			label1.text = str( p_state.talk_markov.get_percentage_value( "love" ) ) + "%"
			label2.text = str( p_state.talk_markov.get_percentage_value( "friend" ) ) + "%"

		ButtonType.Flirt:
			label1.text = str( p_state.flirt_markov.get_percentage_value( "love" ) ) + "%"
			label2.text = str( p_state.flirt_markov.get_percentage_value( "friend" ) ) + "%"

	pass
	
func _on_Button_mouse_entered():
	over_audio.play()
	sprite.material.set_shader_param("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	

func _on_Button_mouse_exited():
	sprite.material.set_shader_param("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_2DOutlineButton_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouse_click"):
		audio.play()
		if button_type == ButtonType.Mention:
			emit_signal("mention_pressed", topic)
			print("pressed ", ButtonType.keys()[button_type], " : ", str(topic))
		else:
			print("pressed ", ButtonType.keys()[button_type])
			emit_signal("button_pressed", button_type)
		
