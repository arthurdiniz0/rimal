extends Control

@onready var animation_player: AnimationPlayer = $TransitionLayer/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_pressed() -> void:
	animation_player.play("fade_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit
