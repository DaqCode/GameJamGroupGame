extends Area2D

@export var level : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		var gm = get_tree().get_first_node_in_group("game_manager")
		gm.emit_signal("next_room")
