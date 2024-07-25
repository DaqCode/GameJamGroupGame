extends Area2D

class_name enemyProjectile

@export var speed: float 

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area):
	if area.name == "EnemyArea":
		pass
	elif area.name == "Hitbox":
		queue_free()
