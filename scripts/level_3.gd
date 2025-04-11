extends Node
@onready var falcon: CharacterBody2D = $falcon
@onready var ground: Area2D = $ground
@export var pipe_scene : PackedScene
@onready var pipetimer: Timer = $pipetimer

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : float = 0.5
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 35
const PIPE_RANGE : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	generate_pipes()
	falcon.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if falcon.flying:
						falcon.flap()
						check_top()

func start_game():
	game_running = true
	falcon.flying = true
	falcon.flap()
	pipetimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll = 0
		ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func check_top():
	if falcon.position.y < 0:
		falcon.falling = true
		stop_game()

func stop_game():
	pipetimer.stop()
	falcon.flying = false
	game_running = false
	game_over = true
	


func _on_pipetimer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = screen_size.y / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(falcon_hit)
	add_child(pipe)
	pipes.append(pipe)
	
func falcon_hit():
	falcon.falling = true
	stop_game()


func _on_ground_hit() -> void:
	falcon.falling = false
	stop_game()
