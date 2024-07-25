extends Node2D

class_name Droppable

enum droppable_type {
	gold,
	health
}

var type: droppable_type

func init_item(type: droppable_type) -> void:
	self.type = type
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		print("+1 Gold")
		area.get_parent().picked_up(type)
		queue_free()
	
