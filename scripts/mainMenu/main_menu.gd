extends Control

func _on_start_pressed()-> void:
	print("Scene changes towards scene")
	# get_tree().change_scene_to_file("res://scenes/dungeonRooms/world1/world_1_room_1.tscn")
	Events.start_match.emit()


func _on_credits_pressed()-> void:
	print("scene changes towards credits")
	Events.load_credits.emit()


func _on_settings_pressed()-> void:
	print("scene changes towards settings")
	#get_tree().change_scene_to_file()


func _on_help_pressed():
	$Help.visible = true


func _on_return_pressed():
	$Help.visible = false
