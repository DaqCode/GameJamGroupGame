extends StaticBody2D

@export var item: InvItem 
var player = null
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func playercollect():
	player.collect(item)


func _on_rose_area_body_entered(body):
	if body.name == "Player":
		$InfoStats.show()
		player = body
		playercollect()
		print("Read what it does")
		await get_tree().create_timer(6.5).timeout
		print("and dissapear")
		audio_stream_player_2d.playing = true
		self.queue_free()


func _on_rose_area_body_exited(body):
	if body.name == "Player":
		$InfoStats.hide()
