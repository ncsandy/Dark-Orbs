extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.orbs_present == false:
		queue_free()


func _on_Orb_body_entered(body):
	if body.name == "Player":
		queue_free()
		Globals.orbs += 1
		Globals.orbs_present = false
		print("You have " + str(Globals.orbs) + " orbs")
	
