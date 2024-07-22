extends Area2D

class_name Projectile



@export var speed := 20

var direction := Vector2.RIGHT


func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_visible_screen_exited() -> void:
	queue_free()

func _on_area_2d_body_entered(body) -> void:
	if body.name == "Enemey":
		print ("bullets hit enemy")
		Enemy.take_damage()
		
