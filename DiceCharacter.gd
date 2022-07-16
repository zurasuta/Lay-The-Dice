extends Node2D


signal state_changed

enum Emotions { Empty, Heart, Friendly, Wrong }

enum { Idle, Angry, Sad, Happy, Love, Change }

export (String) var character_name = "DefaultName"
export (Color) var character_color

onready var emotions_array = [ Emotions.Empty, Emotions.Empty, Emotions.Empty ]
onready var slots = $EmotionSlots
onready var slot1 = $EmotionSlots/EmotionSlot
onready var slot2 = $EmotionSlots/EmotionSlot2
onready var slot3 = $EmotionSlots/EmotionSlot3

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
	print(emotions_array)


func pop_first_emotion():
	emotions_array.pop_front()
			

func update_slots():
	slot1.update_emotion_sprite(emotions_array[0])
	slot2.update_emotion_sprite(emotions_array[1])
	slot3.update_emotion_sprite(emotions_array[2])
	
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
