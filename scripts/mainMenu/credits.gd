extends Control

const MAIN_MENU = preload("res://scenes/mainMenu/main_menu.tscn")
	
func _on_back_pressed() -> void:
	var gm = get_tree().get_first_node_in_group("game_manager")
	gm.emit_signal("main_menu_scene")
