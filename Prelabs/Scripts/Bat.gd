extends KinematicBody2D

var knockback = Vector2.ZERO
var max_health = 10
var health = max_health
var id = "Bat"

onready var health_display  = $HealthDisplay/HealthBar
onready var health_script  = $HealthDisplay
onready var health_label = $HealthDisplay/Label


func _ready():
	health_display.max_value = max_health
	health_label.text = str(health, " / ", max_health)
	health_script.update_name(id)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)
	knockback = move_and_slide(knockback)

func _on_HitBox_area_entered(area):
	health -= 2
	health_display.value -= 2
	health_script.update_healthbar(health)
	health_label.text = str(health, " / ", max_health )
	#debugging purposes
	print(health)
	
	knockback = area.knockback_vector * 120
	yield(get_tree().create_timer(0.8), "timeout")
	if health <= 0:
		queue_free()
	
