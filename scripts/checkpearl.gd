extends Area2D

# This exists only to avoid the player from
# Proceeding without collecting the first pearl

func _on_body_entered(body: Node2D) -> void:
	Dialogic.start("checkpearl")
	
func _process(float) -> void:
	# When the first pearl is collected, this destroys itself
	if Global.tolnote != 1:
		self.free()
