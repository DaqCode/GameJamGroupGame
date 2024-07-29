extends Area2D

@export var level : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		Events.next_room.emit()
