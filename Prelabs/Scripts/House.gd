extends StaticBody2D

onready var house = get_node("../House/Sprite")

func _on_PlayerDector_body_entered(body):
	if body.name == "Player":
		house.self_modulate.a = 0.50


func _on_PlayerDector_body_exited(body):
	if body.name == "Player":
		house.self_modulate.a = 1


func _on_Door_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Prelabs/Interior House/InteriorHouse.tscn")


func _on_SpawnPoint_body_entered(body):
	if body.is_in_group("Player"):
		Globals.last_position = body.global_position
