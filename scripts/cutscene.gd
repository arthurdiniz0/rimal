extends Node2D
@onready var pipes: Area2D = $pipes
@onready var animation_pearl: AnimatedSprite2D = $pipes/animation_pearl
@onready var audio_stream: AudioStreamPlayer = $pipes/animation_pearl/AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $TransitionLayer/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	pipes.position.x -= 350 * delta


func _on_pipes_body_entered(body: Node2D) -> void:
	animation_pearl.visible = false
	audio_stream.play()
	
	# Fade out and next scene
	Global.lvl = 4
	await get_tree().create_timer(0.7).timeout
	animation_player.play("fade_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/lvl3end.tscn")
