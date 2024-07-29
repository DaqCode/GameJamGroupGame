extends StaticBody2D

@export var item: InvItem 
var player = null

func playercollect():
	player.collect(item)

func _on_dark_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		playercollect()

func _on_dark_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide
