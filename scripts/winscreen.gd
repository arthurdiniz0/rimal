extends Control

## This script is for the GUI in between levels,
## Where the user has access to upgrades and collected tolerance notes.


@onready var congrats: Label = $Congrats
@onready var score_ui: Label = $Score/ScoreUI
@onready var tol_notes_panel: Panel = $TolNotesPanel
@onready var tolnote: CanvasLayer = $Tolnote

var local_tolnote = Global.tolnote # Store tolnote number

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Update the number of level and tolnotes collected in the GUI. 
	congrats.text = "Congratulations!\nYou Won!"
	tol_notes_panel.get_node("TolNotes").get_node("TolNotesNum").text = str(Global.tolnote - 1) + " / 5 Collected."
	
	for i in range(1, Global.tolnote): # Enable buttons only of tolnotes already collected
		tol_notes_panel.get_node("Pearl" + str(i)).disabled = false
	
	

		
		

		
		
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
