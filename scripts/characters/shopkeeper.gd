extends CharacterBody2D

var player_in_chat := false
var is_chatting := false

func _process(_delta):
	if Input.is_action_just_pressed("talk"): #This case, its F.
		print ("Chatting with NPC")
		$Dialouge.start()
		
func _on_shopkeeper_area_body_entered(body):
	if body.name == "Player":
		$Dialouge.visible = true
		player_in_chat = true

func _on_shopkeeper_area_body_exited(body):
	if body.name == "Player":
		$Dialouge.visible = false
		player_in_chat = false

func _on_dialouge_dialouge_finished():
	$Dialouge.visible = false
	is_chatting = false
