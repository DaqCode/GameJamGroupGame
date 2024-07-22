extends StaticBody2D

@onready var point_light_2d = $PointLight2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		point_light_2d.visible = false
		print ("Snuffed out")
