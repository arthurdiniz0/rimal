extends CharacterBody2D

var inUse = true
var SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_available: bool = true
@export var coyote_time: float = 0.3

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var coyote_timer: Timer = $Coyote_Timer

func _ready() -> void:
	add_to_group("player")
	
func _physics_process(delta):
		#get_tree().create_timer(coyote_time).timeout.connect(coyote_timeout)
	# Add the gravity.
	if not is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start(coyote_time)		
		velocity.y += gravity * delta
	else:
		if Dialogic.current_timeline == null:
			jump_available = true
			coyote_timer.stop()
	
	# Disable player collision if using camel
	#collision_shape_2d.disabled = not inUse
	if not inUse or not Dialogic.current_timeline == null:
		var direction = Input.get_axis("move_left", "move_right")
		animated_sprite_2d.play("idle")
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_available and Dialogic.current_timeline == null:
		velocity.y = JUMP_VELOCITY
		jump_available = false
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func coyote_timeout():
	jump_available = false
