extends Node2D

var EmotionSlotScene = preload("res://EmotionSlot.tscn")
onready var slot_positioner = $SlotPositioner

export (int) var slots_amount = 3
export (int) var margin = 10


func _ready():
	create_slots(slots_amount)
	offset_slots()
	relocate_slots_by(get_group_width()/2)


func create_slots( amount ):
	for i in amount :
		var n : EmotionSlot = instantiate_emotion_slot()
		n.global_position = slot_positioner.global_position
	

func instantiate_emotion_slot():
	var new_emotion_slot = EmotionSlotScene.instance()
	add_child(new_emotion_slot)
	return new_emotion_slot
	

func get_group_width():
	var width = 0
	for s in get_children():
		if s is EmotionSlot:
			width += s.slot_sprite.texture.get_width()
	return width
	
func offset_slots():
	var offset_position = 0
	for s in get_children():
		if s is EmotionSlot:
			s.global_position.x += offset_position + margin 
			offset_position += s.slot_sprite.texture.get_width() + margin
			
func relocate_slots_by(amount):
	for s in get_children():
		if s is EmotionSlot:
			s.global_position.x -= amount
