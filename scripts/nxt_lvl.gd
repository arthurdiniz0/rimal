extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Global.tolnote == Global.lvl * 2 + 1:	
			game_manager.nxt_lvl()
		else: # If the player didn't collect all pearls
			Dialogic.start("not_enough_pearls") 
			print(Global.tolnote)
		
		
