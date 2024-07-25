extends Area2D

class_name PoisonProjectile

@export var speed := 20
@export var damage := 0
#How would I use this, NO CLUE
@export var damage_over_time := 3

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_visible_screen_exited() -> void:
	queue_free()
	
func _kill_bullet() -> void:
	call_deferred("free")

func _on_poison_area_area_entered(area):
	if area.name == "EnemyArea" or area.name == "LightningArea" or area.name == "BarredArea" or area.name == "ContainedArea":
		_kill_bullet()
