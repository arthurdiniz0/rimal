extends Node2D
@onready var pipes: Area2D = $pipes
@onready var animation_pearl: AnimatedSprite2D = $pipes/animation_pearl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	pipes.position.x -= 350 * delta


func _on_pipes_body_entered(body: Node2D) -> void:
	animation_pearl.visible = false
