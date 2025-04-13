extends Node

@onready var bg_music: AudioStreamPlayer = $bg_music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func play_music():
	bg_music.play()
	
func change_music(number):
	if number == 2:
		bg_music.stream = load("res://assets/music/rimal_soundtrack_2.wav")
	elif number == 1:
		bg_music.stream = load("res://assets/music/rimal_soundtrack_1.wav")
	
