extends KinematicBody2D

var knockback = Vector2.ZERO
var max_health = 10
var health = max_health
var id = "Bat"
var orbReward = 0

onready var health_display  = $HealthDisplay/HealthBar
onready var health_script  = $HealthDisplay
onready var health_label = $HealthDisplay/Label

var rng = RandomNumberGenerator.new()

func _ready():
	health_display.max_value = max_health
	health_label.text = str(health, " / ", max_health)
	health_script.update_name(id)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)
	knockback = move_and_slide(knockback)

func _on_HitBox_area_entered(area):
	health -= 1
	health_display.value -= 1
	health_script.update_healthbar(health)
	health_label.text = str(health, " / ", max_health )
	#debugging purposes
	print(health)
	
	knockback = area.knockback_vector * 120
	yield(get_tree().create_timer(1.0), "timeout")
	if health <= 0:
		orb_amount()
		health_script.death_text(orbReward)
		yield(get_tree().create_timer(0.3), "timeout")
		queue_free()
	
func orb_amount():
	rng.randomize()
	orbReward = rng.randi_range(1, 8)
	Globals.orbs += orbReward
