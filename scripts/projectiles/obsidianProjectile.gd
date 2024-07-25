extends Area2D

class_name ObsidianProjectile

@export var speed := 20
@export var damage := 2

var direction := Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_visible_screen_exited() -> void:
	queue_free()
	
func _kill_bullet() -> void:
	call_deferred("free")

func _on_obsidian_area_area_entered(area):
	if area.name == "EnemyArea" or area.name == "LightningArea" or area.name == "BarredArea" or area.name == "ContainedArea":
		_kill_bullet()	
