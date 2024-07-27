extends Node2D


@onready var door_sprite : Sprite2D = $LockSprite
@onready var door_collider : StaticBody2D = $BlockCollider
@onready var block_shape : CollisionShape2D = $BlockCollider/BlockShape



func _ready() -> void:
	Events.unlock_room.connect(_unlock_room)


func _unlock_room():
	door_sprite.visible = false
	block_shape.set_deferred("disabled", true)

