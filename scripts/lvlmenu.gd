extends Control

@onready var congrats: Label = $Congrats
@onready var score_ui: Label = $Score/ScoreUI
@onready var camel: Button = $UpgradesPanel/Camel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	congrats.text = "Congratulations!\nLevel " + str(Global.lvl) + " Completed."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_ui.text = str(Global.score)


func _on_button_pressed() -> void:
	Global.lvl += 1
	var nxt_lvl_path = "res://scenes/level" + str(Global.lvl) + ".tscn"
	get_tree().change_scene_to_file(nxt_lvl_path)
	print(Global.lvl)
	
	


func _on_camel_pressed() -> void:
	if Global.score >= 10:
		Global.score -= 10
		Global.camel = true
		for children in camel.get_children():
			children.visible = false
		camel.disabled = true 
	else:
		print("vai trabalha o fudido kkkk")
		
