extends CanvasLayer

@onready var note_text: Label = $TolNotesPanel/NoteText
@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: # Update text of the note
	if Global.tolnote == 1:
		note_text.text = "The UAE is home to over 200 nationalities, living and working together in peace."
	elif Global.tolnote == 2:
		note_text.text = "In Emirati tradition, welcoming guests with open arms is a way of demonstrating respect and generosity."
	elif Global.tolnote == 3:
		note_text.text = "Tolerance Clubs in universities encourage youth to lead initiatives that promote coexistence."
	elif Global.tolnote == 4:
		note_text.text = "Sharing water or gahwa (Arabic coffee) with travelers is an age-old sign of generosity and good will in Emirati culture."
	
	# "Closing" tolerance note: make it invisible when pressing key
	if Input.is_action_just_pressed("dialogic_default_action"):
		if get_tree().current_scene.scene_file_path != "res://scenes/lvlmenu.tscn": # If not in between lvls
			if not player.is_physics_processing(): 
				player.set_physics_process(true) # Unfreeze the player
		if self.visible:
			self.visible = false # Make the note invisible
			Global.tolnote += 1
