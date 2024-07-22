extends Node2D

class_name Enemy

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@export var ammo: PackedScene
@export var health: float = 5
var Player

func _ready()-> void:
	Player = get_parent().find_child("Player")

func _physics_process(delta)-> void:
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

func take_damage():
	if health == 0:
		print ("enemy died")
		queue_free()
	else:
		health -= 1
		print("Enemy Health %d" % health)
