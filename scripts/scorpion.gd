extends CharacterBody2D

var SPEED = 60

var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var ground_detector: Area2D = $GroundDetector
@onready var player: CharacterBody2D = $"../Player"
@onready var camel: CharacterBody2D = $"../camel"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func turn_left():
	direction = -1
	animated_sprite.flip_h = true
	animated_sprite.rotation = -24.7

func turn_right():
	direction = 1
	animated_sprite.flip_h = false
	animated_sprite.rotation = 24.7

func _ready() -> void:
	if Global.lvl == 2:
		SPEED = 120

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Global.lvl == 2:
			SPEED = 120
		
	# Flip when hitting a wall	
	if ray_cast_right.is_colliding():
		turn_left()
	if ray_cast_left.is_colliding():
		turn_right()
		
		
	# Behavior for lvl 2
	if Global.lvl == 2:
		
		# Jump when no ground
		if not ground_detector.has_overlapping_bodies() and is_on_floor():
			velocity.y = -300
			SPEED = 180
		
		# Follow player
		if player.inUse: # if the player character is in use
			# follow the player
			if player.position.x < position.x - 100:
				turn_left()
				ground_detector.rotation = PI
			if player.position.x > position.x + 100:
				turn_right()
				ground_detector.rotation = 0
				
		else: # if the player is riding the camel
			# follow the camel
			if camel.position.x < position.x - 100:
				turn_left()
				ground_detector.rotation = PI
			if camel.position.x > position.x + 100:
				turn_right()	
				ground_detector.rotation = 0
	position.x += direction * SPEED * delta
	
	move_and_slide()
