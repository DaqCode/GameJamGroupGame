extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@export var ammo: PackedScene
@export var health: float = 8
@onready var poison_timer: Timer = $PoisonTimer

@onready var item: PackedScene = preload("res://scenes/droppable/droppable.tscn")

var Player

var is_dead = false

var player_within_range := false
var detection_distance := 100.0

func _ready()-> void:
	Player = get_parent().find_child("Player")

func _physics_process(_delta: float)-> void:
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
	_check_player_distance()
	if player_within_range:
		_shoot()
	
func _shoot() -> void:
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast_2d.target_position).normalized()
	get_parent().add_child(bullet)
	$AnimatedSprite2D.look_at(Player.position)
	bullet.look_at(Player.position)


func _check_player_distance() -> void:
	var distance_to_player = position.distance_to(Player.position)
	if distance_to_player < detection_distance:
		player_within_range = true
	else:
		player_within_range = false


func _on_barred_area_area_entered(area):
	if area.name == "BulletArea":
		if health <= 0:
			drop_item()
		health -= 1
	
	elif area.name == "ObsidianArea":
		if health <=0:
			drop_item()
		health -= 2
		
	elif area.name == "DiamondArea":
		if health <=0:
			drop_item()
		health -= 4
	
	elif area.name == "PoisonArea":
		poison_timer.start()
		poison_timer.timeout.connect(
			func():
				if health <= 1:
					health -= 3
				else:
					drop_item()
		)
	
	elif area.name == "throwingArea":
		if health <=0:
			drop_item()
		health -= 1
		
func drop_item() -> void:
	if is_dead:
		return
	is_dead = true
	Events.enemy_died.emit()
	var new_item = item.instantiate()
	new_item.init_item(Droppable.droppable_type.gold)
	new_item.position = position
	get_tree().current_scene.call_deferred("add_child", new_item)
	call_deferred("queue_free")
