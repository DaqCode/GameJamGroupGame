extends Node
@onready var boss: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_boss.tscn")
@onready var lvl1: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_1.tscn")
@onready var lvl2: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_2.tscn")
@onready var treasure: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_3.tscn")
@onready var lvl3: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_4.tscn")
@onready var lvl4: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_5.tscn")
@onready var lvl5: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_room_6.tscn")
@onready var shop: PackedScene = preload("res://scenes/dungeonRooms/world1/world_1_shop.tscn")

var rooms: Array = [boss, lvl1, lvl2, treasure, lvl3, lvl4, lvl5, shop]
var rng := RandomNumberGenerator.new()

func _on_button_pressed():
	randomize()
	rooms.shuffle()
	for i in 8:
		get_tree().change_scene_to_file(rooms[i])
