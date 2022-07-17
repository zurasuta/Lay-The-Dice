extends Node2D


onready var smiley_face = $Sprite/SmileyFaceSprite
onready var sad_face = $Sprite/SadFaceSprite

onready var text_label = $Sprite/Control/Label

func display_smiley():
	smiley_face.visible = true
	sad_face.visible = false
	text_label.visible = false
	
func display_sadface():
	smiley_face.visible = false
	sad_face.visible = true
	text_label.visible = false
	
func display_text():
	smiley_face.visible = false
	sad_face.visible = false
	text_label.visible = true
