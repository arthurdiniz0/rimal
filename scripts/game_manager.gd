extends Node

@onready var scoreui: Label = $UI/ScoreUI
@onready var score_final = $ScoreFinal
@onready var animation_player: AnimationPlayer = $"../TransitionLayer/AnimationPlayer"
@onready var tolnote: CanvasLayer = $"../Tolnote"
@onready var player: CharacterBody2D = $"../Player"
@onready var pearls: Node = $"../Pearls"
@onready var camel: CharacterBody2D = $"../camel"

var style: DialogicStyle = load("res://dialogues/VisualNovelTextbox/stylebasic.tres")
var score = Global.score 


func _ready():
	# Pre-load Dialogic timelines (fix lag)
	style.prepare()
	Dialogic.preload_timeline("res://dialogues/date.dtl")
	
	# Update score in UI
	scoreui.text = str(Global.score)
	
	# Delete already collected pearls
	for i in range(2*Global.lvl - 1, Global.tolnote):
		print("i " + str(i))
		pearls.get_node("Pearl" + str(i)).free()
		
	if Global.lvl == 2:
		if not Global.camel: # If the player didn't buy a camel 
			print("freecamel")
			camel.process_mode = 4 # disable
			camel.visible = false
		else:
			player.get_node("Camera2D").position_smoothing_enabled = false


func add_point(): # This is called by date.gd when a date is collected
	if Global.firstDate: # If it is the first date
		player.set_physics_process(false) # Freeze player
		Dialogic.start("date") # Show message about dates in the UAE
		Global.firstDate = false
	score += 1 # Add point
	score_final.text = "You collected " + str(score) + " dates."
	scoreui.text = str(score) # Update score in the GUI

func tolerance_note(): # This is called by pearl.gd when a pearl is collected
	tolnote.visible = true # Make tolerance note visible
	player.set_physics_process(false) # Freeze player
	# The rest of the process (close the note) will happen at tolnote.gd 
	


func nxt_lvl(): # This is called by nxt_lvl.gd, when the player collides with the object
	animation_player.play("fade_out")
	await get_tree().create_timer(1).timeout
	Global.score = score
	get_tree().change_scene_to_file("res://scenes/lvlmenu.tscn")
