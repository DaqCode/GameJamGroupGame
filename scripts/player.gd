extends CharacterBody2D

@export var speed: float
var dir = Vector2()

func _physics_process(delta):
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	dir = dir.normalized()
	
	if dir:
		velocity = dir * speed * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	$".".look_at(get_global_mouse_position())
	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		print("Pew pew")
