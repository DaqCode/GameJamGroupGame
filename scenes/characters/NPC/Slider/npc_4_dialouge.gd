extends Control

signal dialouge_finished

@export_file("res://scenes/characters/NPC/Slider/sliderdialogue.json") var d_file

var dialouge := []
var current_dialouge_id := 0
var d_active = false

func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialouge = load_dialouge()
	current_dialouge_id = -1
	next_script()

func load_dialouge():
	var file = FileAccess.open("res://scenes/characters/NPC/Slider/sliderdialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _ready():
	$NinePatchRect.visible = false
	
func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("talk"):
		next_script()

func next_script(): 
	current_dialouge_id += 1
	if current_dialouge_id >= len(dialouge):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialouge_finished")
		return 

	$NinePatchRect/Name.text = dialouge[current_dialouge_id]['name']
	$NinePatchRect/Text.text = dialouge[current_dialouge_id]['text']
