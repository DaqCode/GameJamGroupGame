extends Control

func _on_start_pressed()-> void:
	print("Scene changes towards scene")
	# get_tree().change_scene_to_file("res://scenes/dungeonRooms/world1/world_1_room_1.tscn")
	var gm = get_tree().get_first_node_in_group("game_manager")
	gm.emit_signal("start_match")


func _on_credits_pressed()-> void:
	print("scene changes towards credits")
	var gm = get_tree().get_first_node_in_group("game_manager")
	gm.emit_signal("load_credits")


func _on_settings_pressed()-> void:
	print("scene changes towards settings")
	#get_tree().change_scene_to_file()
