extends CharacterBody2D

class_name Player

@export var speed: int = 75
@export var dash_speed: int = 125
@export var dash_time: float = 1.5
@export var dash_cooldown: float = 1.5

@export var current_speed: int

@onready var anim_player: AnimationPlayer = $Anim
@onready var player_sprite: Sprite2D = $Sprite
@onready var book: Node2D = $Book
@onready var book_sprite: Sprite2D = $Book/BookSprite
@onready var projectile_spawn_point: Marker2D = $Book/ProjectileSpawnPoint
@onready var dash_cooldown_bar: ProgressBar = $DashCooldownProgressBar
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer


@onready var projectile: PackedScene = preload("res://scenes/projectiles/projectile.tscn")


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
	
	if not can_dash:
		dash_cooldown_bar.value = dash_cooldown_timer.time_left

func movement(_delta: float) -> void:
	if is_dead:
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
		dash()
		can_shoot = false

func dash() -> void:
	if not can_dash:
		return
	current_speed = dash_speed
	current_state = player_state.dashing
	can_dash = false
	
	dash_timer.start(dash_time)

func is_player_moving() -> bool:
	return input_movement != Vector2.ZERO

func reset_dash() -> void:
	#print("Dash Reset")
	can_shoot = true
	dash_cooldown_bar.max_value = dash_cooldown
	dash_cooldown_bar.value = dash_cooldown
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
	var proj = projectile.instantiate() as Projectile
	proj.direction = projectile_spawn_point.global_position - global_position
	proj.global_position = projectile_spawn_point.global_position
	get_tree().root.add_child(proj)
