extends Node2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@export var ammo: PackedScene
@export var health: float = 5
var Player

func _ready()-> void:
	Player = get_parent().find_child("Player")

func _physics_process(_delta)-> void:
	_aim()
	_check_player_collision()
	
func _aim() -> void:
	ray_cast_2d.target_position = to_local(Player.global_position)

func _check_player_collision()-> void:
	if ray_cast_2d.get_collider() == Player and timer.is_stopped():
		timer.start()
	elif ray_cast_2d.get_collider() != Player and not timer.is_stopped():
		timer.stop()

func _on_timer_timeout()-> void:
	_shoot()
	
func _shoot() -> void:
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast_2d.target_position).normalized()
	get_tree().current_scene.add_child(bullet)

func _on_enemy_area_area_entered(area) -> void:
	if area.name == "BulletArea":
		if health == 1:
			queue_free()
		health -= 1
		print("Health: %s" % health)
		
