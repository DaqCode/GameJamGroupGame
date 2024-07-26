extends CharacterBody2D

@export var ammo: PackedScene
@export var health: float = 1
@export var enemySpeed : int = 150
@onready var poison_timer: Timer = $PoisonTimer

@onready var item: PackedScene = preload("res://scenes/droppable/droppable.tscn")

var Player

func _ready()-> void:
	Player = get_parent().find_child("Player")

func _physics_process(_delta: float)-> void:
	velocity = (Player.position - position).normalized() * enemySpeed
	move_and_slide()

func drop_item() -> void:
	var new_item = item.instantiate()
	new_item.init_item(Droppable.droppable_type.gold)
	new_item.position = position
	get_tree().current_scene.call_deferred("add_child", new_item)
	call_deferred("queue_free")

func _on_lightning_area_area_entered(area) -> void:
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

func _on_lightning_area_body_entered(body):
	if body.name == "Player":
		drop_item()
