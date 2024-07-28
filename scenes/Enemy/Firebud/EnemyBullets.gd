extends Area2D

class_name enemyProjectile

@export var speed: float 
@onready var timer = $Timer

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_screen_exited() -> void:
	queue_free()

func _on_area_entered(area):
	print("Enemy Bullet Collided")
	if area.name == "EnemyArea":
		print("EnemyCollided with self")
		pass

	elif area.name == "Hitbox":
		timer.start()

func _on_timer_timeout():
	queue_free()

