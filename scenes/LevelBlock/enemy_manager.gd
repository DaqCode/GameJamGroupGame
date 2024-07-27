extends Node2D


@export var number_of_enemies : int

var number_of_alive_enemies: int = 0


func _ready() -> void:
	
	if number_of_enemies == 0:
		Events.unlock_room.emit()
		return
	number_of_alive_enemies = number_of_enemies
	print("Enemies: ", number_of_alive_enemies)
	Events.enemy_died.connect(on_enemy_died)


func on_enemy_died() -> void:
	number_of_alive_enemies -= 1
	print("Enemy Died: ", number_of_alive_enemies)
	
	if number_of_alive_enemies <= 0:
		Events.unlock_room.emit()
