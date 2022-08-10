extends Node2D

onready var playerSpawn = preload("res://Prelabs/Player/Player.tscn")

func _ready():
	call_deferred("_spawn_player")
	
func _spawn_player():
	var player = playerSpawn.instance()
	get_parent().get_node("InteriorHouse").add_child(player)
	player.global_position = $HouseSpawnPoint.global_position

func _on_DoorExit_body_entered(body):
	get_tree().change_scene("res://Prelabs/Levels/Main.tscn")
