extends StaticBody2D

@export var cost: int = 5

var player = null


func _on_health_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		player.can_buy_health = true
		player.item_cost = cost

func _on_health_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
		player = body
		player.can_buy_health = false
		player.item_cost = 0
