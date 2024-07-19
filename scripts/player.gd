extends CharacterBody2D

class_name Player

@export var speed: int

@onready var anim_player: AnimationPlayer = $Anim
@onready var player_sprite: Sprite2D = $Sprite
@onready var book: Node2D = $Book
@onready var book_sprite: Sprite2D = $Book/BookSprite
@onready var projectile_spawn_point: Marker2D = $Book/ProjectileSpawnPoint


enum player_state {
	idle,
	moving,
	dead
}

var input_movement := Vector2()
var current_state := player_state.idle
var is_dead := false

var pos: Vector2
var rot: float


func _process(delta: float) -> void:
	aim_toward_mouse()
	movement(delta)


func movement(delta: float) -> void:
	if is_dead:
		return

	play_animations()
	input_movement = get_input_vector()
	
	if is_player_moving():
		velocity = input_movement * speed
		current_state = player_state.moving
	else:
		velocity = Vector2.ZERO
		current_state = player_state.idle

	move_and_slide()


func is_player_moving() -> bool:
	return input_movement != Vector2.ZERO


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


func aim_toward_mouse() -> void:
	var mouse := get_global_mouse_position()
	pos = global_position
	book.look_at(mouse)
	rot = rad_to_deg((mouse - pos).angle())
	
	if is_aiming_right(rot):
		flip_player_and_book(false)
	else:
		flip_player_and_book(true)


func is_aiming_right(rotation: float) -> bool:
	return rotation >= -90 and rotation <= 90


func flip_player_and_book(flip: bool) -> void:
	book_sprite.flip_v = flip
	player_sprite.flip_h = flip
