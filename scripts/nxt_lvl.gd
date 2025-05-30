extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $"../TransitionLayer/AnimationPlayer"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Global.lvl == 4:
			Global.lvl = 5
			animation_player.play("fade_out")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/winscreen.tscn")
			return
		
		if Global.tolnote == Global.lvl * 2 + 1:	
			game_manager.nxt_lvl()
		else: # If the player didn't collect all pearls
			Dialogic.start("not_enough_pearls") 
			print(Global.tolnote)
		
		
