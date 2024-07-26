extends Node

signal load_entry
signal next_room
signal load_menu
signal start_match

var main_menu_scene = "res://scenes/mainMenu/main_menu.tscn"
var entry_scene = "res://scenes/dungeonRooms/entry_scene.tscn"

var dungeon_scenes = [
	"res://scenes/dungeonRooms/world1/world_1_room_1.tscn",
	"res://scenes/dungeonRooms/world1/world_1_room_2.tscn",
	"res://scenes/dungeonRooms/world1/world_1_room_4.tscn",
	"res://scenes/dungeonRooms/world1/world_1_room_5.tscn",
	"res://scenes/dungeonRooms/world1/world_1_room_6.tscn"
]

var shop_scenes = [
	"res://scenes/dungeonRooms/world1/world_1_shop.tscn"
]

var boss_scenes = [
	"res://scenes/dungeonRooms/world1/world_1_boss.tscn"
]

var treasure_scenes =[
	"res://scenes/dungeonRooms/world1/world_1_room_3.tscn"
]

var room_number = 0

var shop_occurance = [ 3, 7 ]
var treasure_occurance = [ 5 ]
var boss_occurance = [ 8 ]

var level_instance

var coins: int = 0
var health: int = 3
var enemy_count: int = 0

@onready var container = $Container

func _ready() -> void:
	connect("next_room", self.go_to_next_room)
	connect("start_match", self.load_first_room)
	connect("load_menu", self.load_main_menu)
	connect("load_entry", self.load_entry_scene)
	level_instance = load(main_menu_scene).instantiate()
	level_instance.anchor_left = 0.5
	level_instance.anchor_top = 0.5
	level_instance.anchor_right = 0.5
	level_instance.anchor_bottom = 0.5
	level_instance.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	container.add_child(level_instance)


func go_to_main_menu() -> void:
	room_number = 0
	load_main_menu()


func load_first_room() -> void:
	load_level()


func load_entry_scene() -> void:
	unload_level()
	level_instance = load(entry_scene).instantiate()
	container.add_child(level_instance)


func go_to_next_room() -> void:
	room_number += 1
	load_level()


func unload_level() -> void:
	if (is_instance_valid(level_instance)):
		container.call_deferred("remove_child",level_instance)
	level_instance = null


func load_main_menu() -> void:
	unload_level()
	level_instance = load(main_menu_scene).instantiate()
	level_instance.anchor_left = 0.5
	level_instance.anchor_top = 0.5
	level_instance.anchor_right = 0.5
	level_instance.anchor_bottom = 0.5
	#level_instance.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	container.add_child(level_instance)


func load_level() -> void:
	unload_level()
	var scene_to_load
	print("Room number: ", room_number)
	if shop_occurance.has(room_number):
		print("Should be Shop")
		scene_to_load = shop_scenes[randi_range(0, shop_scenes.size() - 1)]
	elif boss_occurance.has(room_number):
		print("Should be boss")
		scene_to_load = boss_scenes[randi_range(0, boss_scenes.size() - 1 )]
	elif treasure_occurance.has(room_number):
		print("Should be Treasure")
		scene_to_load = treasure_scenes[randi_range(0, treasure_scenes.size() - 1)]
	else:
		print("Should be normal")
		scene_to_load = dungeon_scenes[randi_range(0, dungeon_scenes.size() - 1 )]

	level_instance = load(scene_to_load).instantiate()
	container.call_deferred("add_child",level_instance)
