extends Area2D

class_name Projectile

@export var speed := 20

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_visible_screen_exited() -> void:
	queue_free()
	
func _kill_bullet() -> void:
	call_deferred("free")

func _on_area_2d_area_entered(area):
	if area.name == "EnemyArea":
		_kill_bullet()	
