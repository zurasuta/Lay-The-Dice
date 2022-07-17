extends Node2D

onready var slot_sprite = $SlotSprite
onready var emotion_sprite = $EmotionSprite
onready var animation = $AnimationPlayer

onready var active_shader = false

func update_emotion_sprite( value ):
	emotion_sprite.frame = value

func switch_active_shader():
	active_shader = !active_shader
	emotion_sprite.material.set_shader_param("active", active_shader)

func play_blink():
	animation.play("Blink")
	
func stop_blink():
	animation.stop()
	active_shader = false
	animation.play("Idle")
