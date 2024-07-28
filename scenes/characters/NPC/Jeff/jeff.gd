extends CharacterBody2D

var player_in_chat := false
var is_chatting := false

func _process(_delta):
	if Input.is_action_just_pressed("talk"): #This case, its F.
		print ("Chatting with NPC")
		$npc4_dialouge.start()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$npc4_dialouge.visible = true
		player_in_chat = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$npc4_dialouge.visible = false
		player_in_chat = false


func _on_npc_4_dialouge_dialouge_finished():
	$npc4_dialouge.visible = false
	is_chatting = false