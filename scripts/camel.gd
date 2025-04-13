extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ridercontainer: Node2D = $ridercontainer
@onready var riderposition: Marker2D = $riderposition
@onready var area_2d: Area2D = $Area2D
@onready var coyote_timer: Timer = $Coyote_Timer

@export var coyote_time: float = 0.3
const SPEED = 230.0
const JUMP_VELOCITY = -300.0

var inUse = false
var jump_available: bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start(coyote_time)
		velocity += get_gravity() * delta
	else:
		jump_available = true
		coyote_timer.stop()
		
	if not inUse:
		animated_sprite_2d.play("idle")
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_available:
		velocity.y = JUMP_VELOCITY
		jump_available = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("running")
	else:
		animated_sprite_2d.play("jump")

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:	
	if body.is_in_group("player"):
		body.inUse = false
		body.animated_sprite_2d.flip_h = animated_sprite_2d.flip_h
		call_deferred("do_ride", body)
	
func do_ride(rider):
	rider.reparent(ridercontainer)
	rider.global_position = riderposition.global_position
	inUse = true
	area_2d.set_collision_mask_value(1, true)
	area_2d.set_collision_mask_value(2, false)
	
	#disable collision of player, keep only the camel one
	#this is to avoid conflict with the flag for nxt_lvl
	#rider.set_collision_mask_value(1, true)
	#rider.set_collision_mask_value(2, false)
	#print("collision changed")
	
	# Turn position smoothing back on
	await get_tree().create_timer(0.1).timeout
	rider.get_node("Camera2D").position_smoothing_enabled = true

func coyote_timeout():
	jump_available = false
