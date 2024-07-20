extends Area2D

class_name Projectile

@export var speed := 20

var direction := Vector2.RIGHT


func _process(delta: float) -> void:
	translate(direction * speed * delta)


func _on_visible_screen_exited() -> void:
	queue_free()
