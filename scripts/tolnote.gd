extends CanvasLayer

@onready var note_text: Label = $TolNotesPanel/NoteText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	note_text.text = "The UAE is home to over 200 nationalities, living and working together in peace."
