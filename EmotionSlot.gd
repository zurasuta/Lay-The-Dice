extends Node2D

class_name EmotionSlot


onready var slot_sprite = $SlotSprite
onready var emotion_sprite = $EmotionSprite


func update_emotion_sprite( value ):
	emotion_sprite.frame = value
