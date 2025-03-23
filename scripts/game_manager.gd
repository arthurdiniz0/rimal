extends Node

@onready var scoreui: Label = $UI/ScoreUI
@onready var score_final = $ScoreFinal
@onready var animation_player: AnimationPlayer = $"../TransitionLayer/AnimationPlayer"
@onready var tolnote: CanvasLayer = $"../Tolnote"

var score = Global.score 

func _ready():
	scoreui.text = str(Global.score)
	print("camel: " + str(Global.camel))

func _process(float) -> void:
	if tolnote.visible:
		tolnote.visible = false

func add_point():
	if Global.firstDate:
		Dialogic.start("date")
		Global.firstDate = false
	score += 1
	score_final.text = "You collected " + str(score) + " dates."
	scoreui.text = str(score)

func tolerance_note():
	##Dialogic.start("pearl")
	tolnote.visible = true
	print("rodou")

func nxt_lvl():
	animation_player.play("fade_out")
	await get_tree().create_timer(1).timeout
	Global.score = score
	get_tree().change_scene_to_file("res://scenes/lvlmenu.tscn")
