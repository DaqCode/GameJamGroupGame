extends Area2D

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		GameManager.enemy_count += 1
