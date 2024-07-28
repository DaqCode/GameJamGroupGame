extends Area2D

class_name BarredProjectile

@export var speed: float 

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_screen_exited():
	queue_free()

func _on_area_entered(area) -> void:
	print("Enemy Bullet Collided")
	if area.name == "BarredArea":
		print("EnemyCollided with self")
		pass
	#elif area.name == "Hitbox":
	else:
		queue_free()
