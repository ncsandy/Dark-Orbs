extends YSort

onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.last_position:
		player.global_position = Globals.last_position
		print(player.global_position)
