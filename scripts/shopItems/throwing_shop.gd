extends CharacterBody2D

@export var cost: int = 24

var player: Player

func _on_throwing_buy_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		player.can_buy_throwing = true
		player.item_cost = cost


func _on_throwing_buy_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
		player = body
		player.can_buy_throwing = false
		player.item_cost = 0
