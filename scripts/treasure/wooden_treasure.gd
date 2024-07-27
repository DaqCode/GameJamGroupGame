extends CharacterBody2D
@onready var wooden_treasure = $"."

func _on_wooden_area_body_entered(body):
	if body.name == "Player":
		print ("Player stepped over")
		$InfoStats.show()
		ItemPickupManager.has_woodenBandana = true
		print("Player now has woodenBanada")
		wooden_treasure.visible = false

func _on_wooden_area_body_exited(body):
	if body.name == "Player":
		print("Player left")
		$InfoStats.hide()
