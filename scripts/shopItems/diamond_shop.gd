extends CharacterBody2D


func _on_diamond_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()


func _on_diamond_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
