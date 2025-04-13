extends Node
@onready var falcon: CharacterBody2D = $Player
@onready var ground: Area2D = $ground
@export var pipe_scene : PackedScene
@onready var pipetimer: Timer = $pipetimer
@onready var scoreui: Label = $UI/ScoreUI
@onready var animation_player: AnimationPlayer = $TransitionLayer/AnimationPlayer

var game_running : bool
var game_over : bool
var scroll
const SCROLL_SPEED : float = 350 # 4
#var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100 # 100
const PIPE_RANGE : int = 150 # 200

var initial_score = Global.score 
# Called when the node enters the scene tree for the first time.
func _ready():
	Music.change_music(2)
	Music.play_music()
	Global.tolnote = 5
	#screen_size = get_window().size
	ground_height = ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func new_game():
	#reset variables
	game_running = false
	game_over = false
	scroll = 0
	pipes.clear()
	generate_pipes()
	falcon.reset()
	
func _input(event):
	if game_over == false:
		if Input.is_action_just_pressed("jump"):
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
	initial_score = Global.score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		scroll += SCROLL_SPEED * delta
		if scroll >= 1152:
			scroll = 0
		ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED * delta
		
	scoreui.text = str(Global.score) # Update score in the GUI
	if Global.score == 25: # Win condition
		animation_player.play("fade_out")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/cutscene.tscn") # send to cutscene

func check_top():
	if falcon.position.y < 0:
		falcon.falling = true
		stop_game()

func stop_game():
	pipetimer.stop()
	falcon.flying = false
	game_running = false
	game_over = true
	
	# restart level
	await get_tree().create_timer(1).timeout
	Global.score = initial_score
	get_tree().reload_current_scene()

	


func _on_pipetimer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = 1152 + PIPE_DELAY
	pipe.position.y = 648 / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(falcon_hit)
	
	add_child(pipe)
	pipes.append(pipe)
	
func falcon_hit():
	print("hit")
	falcon.falling = true
	stop_game()


func _on_ground_hit() -> void:
	falcon.falling = false
	stop_game()
