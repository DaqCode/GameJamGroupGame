extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@export var ammo: PackedScene
@export var health: float = 5
@export var enemySpeed : int = 50
@onready var poison_timer: Timer = $PoisonTimer

@onready var item: PackedScene = preload("res://scenes/droppable/droppable.tscn")


var Player

func _ready()-> void:
	Player = get_parent().find_child("Player")

func _physics_process(_delta)-> void:
	velocity = Player.position - position
	_aim()
	_check_player_collision()
	move_and_slide()
	
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
		
func drop_item() -> void:
	var new_item = item.instantiate()
	new_item.init_item(Droppable.droppable_type.health)
	new_item.position = position
	get_tree().current_scene.add_child(new_item)
	call_deferred("queue_free")
