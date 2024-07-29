extends CharacterBody2D

@export var cost: int = 22
var player: Player

func _on_diamond_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		player.can_buy_diamond = true
		player.item_cost = cost


func _on_diamond_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
		player = body
		player.can_buy_diamond = false
		player.item_cost = 0
