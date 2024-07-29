extends CharacterBody2D

@export var cost: int = 18

var player: Player

func _on_obsidian_buy_body_entered(body):
	if body.name == "Player":
		player = body
		player.can_buy_obsidian = true
		player.item_cost = cost
		$InfoStats.show()

func _on_obsidian_buy_body_exited(body):
	if body.name == "Player":
		player = body
		player.can_buy_obsidian = true
		player.item_cost = 0
		$InfoStats.hide()
