extends CharacterBody2D

@export var cost: int = 20

var player: Player

func _on_poison_buy_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		player.can_buy_poison = true
		player.item_cost = cost

func _on_poison_buy_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
		player = body
		player.can_buy_poison = false
		player.item_cost = 0
