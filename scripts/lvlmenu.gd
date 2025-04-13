extends Control

## This script is for the GUI in between levels,
## Where the user has access to upgrades and collected tolerance notes.


@onready var congrats: Label = $Congrats
@onready var score_ui: Label = $Score/ScoreUI
@onready var camel: Button = $UpgradesPanel/Camel
@onready var tol_notes_panel: Panel = $TolNotesPanel
@onready var tolnote: CanvasLayer = $Tolnote
@onready var falcon: Button = $UpgradesPanel/Falcon
@onready var animation_player: AnimationPlayer = $TransitionLayer/AnimationPlayer

var local_tolnote = Global.tolnote # Store tolnote number

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Update the number of level and tolnotes collected in the GUI. 
	congrats.text = "Congratulations!\nLevel " + str(Global.lvl) + " Completed."
	if Global.lvl == 3: 
		congrats.text = "Congratulations!\nGame Completed!"
	tol_notes_panel.get_node("TolNotes").get_node("TolNotesNum").text = str(Global.tolnote - 1) + " / 5 Collected."
	
	for i in range(1, Global.tolnote): # Enable buttons only of tolnotes already collected
		tol_notes_panel.get_node("Pearl" + str(i)).disabled = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Updating score has to be real time, in case the user buys an upgrade
	score_ui.text = str(Global.score)
	
	if Global.camel:
		for children in camel.get_children(): # Disable button
			children.visible = false
		camel.disabled = true 
	
	if Global.falcon:
		for children in falcon.get_children(): # Disable button
			children.visible = false
		falcon.disabled = true 


func _on_button_pressed() -> void: # Next level button
	Global.lvl += 1 # Increasing global variable lvl
	var nxt_lvl_path = "res://scenes/level" + str(Global.lvl) + ".tscn"
	Global.tolnote = local_tolnote # retreive tolnote number
	if Global.lvl == 2 and not Global.camel:
		Dialogic.start("need_camel")
		Global.lvl -= 1
		return
	if Global.lvl == 3 and not Global.falcon:
		Dialogic.start("need_falcon")
		Global.lvl -= 1
		return
	animation_player.play("fade_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(nxt_lvl_path) # Change scene to next lvl
	print("Level: ", Global.lvl)
	
	
	


func _on_camel_pressed() -> void: # Buy camel
	if Global.score >= 15: # If there is enough dates
		Global.score -= 15
		Global.camel = true
	else: # If there isn't enough dates
		print("Not enough dates")
		
		

		
		
# Below there is the logic to open the tolnotes in the panel

func _on_pearl_1_pressed() -> void:
	Global.tolnote = 1
	tolnote.visible = true
	



func _on_pearl_2_pressed() -> void:
	Global.tolnote = 2
	tolnote.visible = true


func _on_pearl_3_pressed() -> void:
	Global.tolnote = 3
	tolnote.visible = true


func _on_pearl_4_pressed() -> void:
	Global.tolnote = 4
	tolnote.visible = true


func _on_pearl_5_pressed() -> void:
	Global.tolnote = 5
	tolnote.visible = true


func _on_pearl_6_pressed() -> void:
	Global.tolnote = 6
	tolnote.visible = true


func _on_falcon_pressed() -> void:
	if Global.score >= 30: # If there is enough dates
		Global.score -= 30
		Global.falcon = true
	else: # If there isn't enough dates
		print("Not enough dates")
