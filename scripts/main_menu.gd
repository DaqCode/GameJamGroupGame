extends Control

func _on_start_pressed()-> void:
	print("Scene changes towards scene")
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_credits_pressed()-> void:
	print("scene changes towards credits")
	get_tree().change_scene_to_file("res://scenes/mainMenu/credits.tscn")


func _on_settings_pressed()-> void:
	print("scene changes towards settings")
	#get_tree().change_scene_to_file()
