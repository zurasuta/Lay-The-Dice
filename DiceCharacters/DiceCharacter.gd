extends Node2D


signal state_changed
signal emotions_matched

enum Emotions { Empty, Heart, Friendly, Wrong }

enum { Idle, Angry, Sad, Happy, Love, Change }

export (String) var character_name = "DefaultName"
export (Color) var character_color

onready var emotions_array = [ Emotions.Empty, Emotions.Empty, Emotions.Empty ]
onready var slots = $EmotionSlotGroup
onready var slot1 = $EmotionSlotGroup/EmotionSlot
onready var slot2 = $EmotionSlotGroup/EmotionSlot2
onready var slot3 = $EmotionSlotGroup/EmotionSlot3

onready var animation_player = $AnimationPlayer
onready var state = Idle setget set_state

onready var rng = RandomNumberGenerator.new()

func set_state(value):
	state = value
	emit_signal("state_changed")
	update_animation_state()
 
func _ready():
	update_slots()

func push_emotion( emotion ):
	emotions_array.push_back(emotion)
	pop_first_emotion()
	var m = check_for_match()
	if m:
		emit_signal("emotions_matched", emotions_array[0])


func pop_first_emotion():
	emotions_array.pop_front()
			

func update_slots():
	slot1.update_emotion_sprite(emotions_array[2])
	slot2.update_emotion_sprite(emotions_array[1])
	slot3.update_emotion_sprite(emotions_array[0])
	

func check_for_match():
	
	return emotions_array[0] == emotions_array[1] and emotions_array[0] == emotions_array[2]
	
func update_animation_state():
	match state:
		Idle:
			animation_player.play("Idle")
			push_emotion(Emotions.Empty)



		Angry:
			animation_player.play("Angry")
			push_emotion(Emotions.Wrong)



		Sad:
			pass
		Happy:
			animation_player.play("Happy")
			push_emotion(Emotions.Friendly)



		Love:
			animation_player.play("Love")
			push_emotion(Emotions.Heart)

	
	update_slots()
	
		
func perform_change():
	animation_player.play("Change")

func change_to_random_state():
	rng.randomize()
	var r = rng.randi_range(1, 4)
	print(r)
	match r:
		1:
			self.state = Idle
		2:
			self.state = Angry
		3:
			self.state = Happy
		4:
			self.state = Love