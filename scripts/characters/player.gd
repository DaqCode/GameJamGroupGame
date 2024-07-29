extends CharacterBody2D

class_name Player

@export var speed: int = 75
@export var dash_speed: int = 125
@export var dash_time: float = 1.5
@export var dash_cooldown: float = 1.5
@export var current_speed: int
@export var health: int = 5

@export var inv: Inv 

@onready var anim_player: AnimationPlayer = $Anim
@onready var player_sprite: Sprite2D = $Sprite
@onready var book: Node2D = $Book
@onready var book_sprite: Sprite2D = $Book/BookSprite
@onready var projectile_spawn_point: Marker2D = $Book/ProjectileSpawnPoint
@onready var dash_cooldown_bar: ProgressBar = $DashCooldownProgressBar
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer
@onready var death_time: Timer = $DeathTimer

@onready var diamond_projectile: PackedScene = preload("res://scenes/projectiles/diamondProjectiles.tscn")
@onready var projectile: PackedScene = preload("res://scenes/projectiles/projectile.tscn")
@onready var obsidian_projectile: PackedScene = preload("res://scenes/projectiles/obsidianProjectile.tscn")
@onready var poison_projectile: PackedScene = preload("res://scenes/projectiles/poisonProjectile.tscn")
@onready var throwing_projectile = preload("res://scenes/projectiles/throwingProjectiles.tscn")
@onready var hitbox_coliider: CollisionShape2D = $Hitbox/HitboxCollider

var has_projectile = false
var has_obsidian_projectile = false
var can_buy_obsidian = false
var has_diamond_projectile = false
var can_buy_diamond = false
var has_poison_projectile = false
var can_buy_poison = false
var has_throwing_projectile = true
var can_buy_throwing = false

var can_buy_health = false
var can_buy_speed = false

var item_cost := 0

var in_dash_cooldown := false

enum player_state {
	idle,
	moving,
	dead,
	dashing
}

var input_movement := Vector2()
var current_state := player_state.idle
var is_dead := false
var can_dash := true
var can_shoot := true

var pos: Vector2
var rot: float

func _ready() -> void:
	current_speed = speed
	dash_timer.timeout.connect(reset_dash)
	

func _process(delta: float) -> void:
	aim_toward_mouse()
	handle_input()
	movement(delta)
	
	$GoldCoins.text = "Coins: %s" % GameManager.coins
	
	if in_dash_cooldown:
		dash_cooldown_bar.value -= delta
	
	

func movement(_delta: float) -> void:
	if is_dead:
		play_animations()
		return
		
	play_animations()
	input_movement = get_input_vector()
	
	if is_player_moving():
		velocity = input_movement * current_speed
		if current_state != player_state.dashing:
			current_state = player_state.moving
	else:
		velocity = Vector2.ZERO
		current_state = player_state.idle

	move_and_slide()

func handle_input() -> void:
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			fire_projectile()
	
	if Input.is_action_just_pressed("dash"):
		if is_player_moving():
			dash()
			can_shoot = false
	
	if Input.is_action_just_pressed("pickup"):
		if can_buy_obsidian and GameManager.coins >= item_cost:
			has_obsidian_projectile = true
			GameManager.coins -= item_cost
			can_buy_obsidian = false
		if can_buy_diamond and GameManager.coins >= item_cost:
			has_diamond_projectile = true
			GameManager.coins -= item_cost
			can_buy_diamond = false
		if can_buy_poison and GameManager.coins >= item_cost:
			has_poison_projectile = true
			GameManager.coins -= item_cost
			can_buy_poison = false
		if can_buy_throwing and GameManager.coins >= item_cost:
			has_throwing_projectile = true
			GameManager.coins -= item_cost
			can_buy_throwing = false
		if can_buy_health and GameManager.coins >= item_cost:
			health += 1
			GameManager.coins -= item_cost
			can_buy_health = false
		if can_buy_speed and GameManager.coins >= item_cost:
			speed += 25
			GameManager.coins -= item_cost
			can_buy_speed = false

func dash() -> void:
	if not can_dash:
		return
	current_speed = dash_speed
	current_state = player_state.dashing
	can_dash = false
	hitbox_coliider.disabled = true
	#dash_cooldown_bar.value = dash_cooldown
	
	
	dash_timer.start(dash_time)

func is_player_moving() -> bool:
	return input_movement != Vector2.ZERO

func reset_dash() -> void:
	can_shoot = true
	dash_cooldown_bar.max_value = dash_cooldown
	#dash_cooldown_bar.value = 0
	current_state = player_state.moving
	current_speed = speed
	dash_cooldown_timer.stop()
	dash_cooldown_timer.start(dash_cooldown)
	dash_cooldown_timer.timeout.connect(
		func():
			can_dash = true
	)

func get_input_vector() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func play_animations() -> void:
	match current_state:
		player_state.idle:
			anim_player.play("idle")
		player_state.moving:
			anim_player.play("move")
		player_state.dead:
			anim_player.play("dead")
			is_dead = true
		player_state.dashing:
			anim_player.play("shadow")

func aim_toward_mouse() -> void:
	var mouse := get_global_mouse_position()
	pos = global_position
	book.look_at(mouse)
	rot = rad_to_deg((mouse - pos).angle())
	
	if is_aiming_right(rot):
		flip_player_and_book(false)
	else:
		flip_player_and_book(true)

func is_aiming_right(new_rot: float) -> bool:
	return new_rot >= -90 and new_rot <= 90

func flip_player_and_book(flip: bool) -> void:
	book_sprite.flip_v = flip
	player_sprite.flip_h = flip

func fire_projectile() -> void:
	if has_projectile:
		var proj = projectile.instantiate() as Projectile
		proj.direction = projectile_spawn_point.global_position - global_position
		proj.global_position = projectile_spawn_point.global_position
		proj.look_at(get_global_mouse_position())
		get_tree().root.add_child(proj)
		
	elif has_poison_projectile:
		var proj = poison_projectile.instantiate() as PoisonProjectile
		proj.direction = projectile_spawn_point.global_position - global_position
		proj.global_position = projectile_spawn_point.global_position
		proj.look_at(get_global_mouse_position())
		get_tree().root.add_child(proj)
		
	elif has_diamond_projectile:
		var proj = diamond_projectile.instantiate() as DiamondProjectile   
		proj.direction = projectile_spawn_point.global_position - global_position
		proj.global_position = projectile_spawn_point.global_position
		proj.look_at(get_global_mouse_position())
		get_tree().root.add_child(proj)
	
	elif has_obsidian_projectile:
		var proj = obsidian_projectile.instantiate() as ObsidianProjectile
		proj.direction = projectile_spawn_point.global_position - global_position
		proj.global_position = projectile_spawn_point.global_position
		proj.look_at(get_global_mouse_position())
		get_tree().root.add_child(proj)
	
	elif has_throwing_projectile:
		var spread_angle = deg_to_rad(10)
		var base_dir = (projectile_spawn_point.global_position - global_position).normalized()
		for i in range(3):
			var proj = throwing_projectile.instantiate() as ThrowingProjectile
			proj.global_position = projectile_spawn_point.global_position
			var angle_offset = spread_angle * (i - 1)
			var spread_dir = base_dir.rotated(angle_offset)
			proj.direction = spread_dir
			proj.look_at(get_global_mouse_position())
			get_tree().root.add_child(proj)
			
	else:
		var proj = projectile.instantiate() as Projectile
		proj.direction = projectile_spawn_point.global_position - global_position
		proj.global_position = projectile_spawn_point.global_position
		proj.look_at(get_global_mouse_position())
		get_tree().root.add_child(proj)

func _on_hitbox_area_entered(area):
	if health >= 0:
		if area.name == "EnemyBullets":
			health -= 1
			print ("Player Health %s" % health)
			print ("Damaged by fireball bullet")
		if area.name == "LightningArea":
			health -= 2
			print ("Player Health %s" % health)
			print ("Damaged by Lightning Nightmare")
		if area.name == "BarredProj":
			health -= 1
			print ("Player Health %s" % health)
			print ("Damaged by Barred Light")
		if area.name == "ContainedProj":
			health -= 1
			print ("Player Health %s" % health)
			print ("Damaged by Contained Light")
		
	elif health <= 0 and not is_dead:
		is_dead = true
		death_time.start()

func _on_death_timer_timeout():
	Events.load_entry.emit()

func picked_up(type: Droppable.droppable_type) -> void:
	match(type):
		Droppable.droppable_type.gold:
			GameManager.coins += randf_range(1,3)
			$GoldCoins.text = "Coins: %s" % GameManager.coins
		Droppable.droppable_type.health:
			print("Picked up health...")
			
func collect(item):
	inv.insert(item)


func _on_dash_timer_timeout() -> void:
	print("Dash Timer Timedout")
	reset_dash()
	in_dash_cooldown = true
	dash_cooldown_bar.value = dash_cooldown
	hitbox_coliider.disabled = false
