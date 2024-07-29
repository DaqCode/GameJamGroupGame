extends StaticBody2D

@export var cost: int = 7

var player = null


func _on_speed_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		player.can_buy_speed = true
		player.item_cost = cost


func _on_speed_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
		player = body
		player.can_buy_speed = false
		player.item_cost = 0
