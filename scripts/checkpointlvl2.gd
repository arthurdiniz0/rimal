extends Area2D

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered (body: Node2D) -> void:
	if body.is_in_group("player"):
		rigid_body_2d.free() 
		self.queue_free()
		#collision_shape_2d.disabled = true
