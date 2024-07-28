extends Control

const MAIN_MENU = preload("res://scenes/mainMenu/main_menu.tscn")
	
func _on_back_pressed() -> void:
	Events.load_menu.emit()
