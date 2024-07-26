extends Area2D

class_name BarredProjectile

@export var speed: float 

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.name == "BarredArea":
		pass
	elif area.name == "Hitbox":
		queue_free()