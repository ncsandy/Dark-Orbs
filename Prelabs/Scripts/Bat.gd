extends KinematicBody2D

#Attributes and knockbock
var knockback = Vector2.ZERO
var max_health = 10
var health = max_health
var id = "Bat"
var orbReward = 0
var rng = RandomNumberGenerator.new()

#Aggro ring behaviour
var velocity = Vector2.ZERO
var speed = 120
var max_speed = 150
var friction = 0
var player = null

var state = ATTACK

onready var health_display  = $HealthDisplay/HealthBar
onready var health_script  = $HealthDisplay
onready var health_label = $HealthDisplay/Label

enum{
	IDLE,
	ATTACK
}

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			player_detect()
		ATTACK:
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * speed, max_speed * delta)
			else:
				state = IDLE
				player = null
	
	$Sprite.flip_h = velocity.x > 0
	velocity = move_and_slide(velocity)
	
func player_detect():
	if player_detectable():
		state = ATTACK
			
func player_detectable():
	return player != null
		
func _on_AggroRing_body_entered(body):
	if body.name == "Player":
		player = body
		
func _on_AggroRing_body_exited(body):
	if body.name == "Player":
		player = null
		velocity = Vector2.ZERO

func _ready():
	health_display.max_value = max_health
	health_label.text = str(health, " / ", max_health)
	health_script.update_name(id)

func _on_HitBox_area_entered(area):
	health -= 1
	health_display.value -= 1
	health_script.update_healthbar(health)
	health_label.text = str(health, " / ", max_health )
	
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
