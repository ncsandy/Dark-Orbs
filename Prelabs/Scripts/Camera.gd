extends Camera2D

onready var player = get_node("../Player")

func process(delta):
	position = player.global_position
	var x = floor(position.x / 820) * 820
	var y = floor(position.y / 480) * 480
	global_position = Vector2(x,y)
