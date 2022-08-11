extends KinematicBody2D

var state = MOVE

enum{
	MOVE,
	ATTACK
}

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")
onready var attack_state = $Attack
onready var walk_state = $Walk
onready var spell = $Spell
var spell_vector = Vector2.ZERO

func _ready():
	spell.knockback_vector = spell_vector

var speed = 200
var velocity = Vector2.ZERO

func _physics_process(delta):
	match state:
		MOVE:
			attack_state.hide()
			Move_state()
		ATTACK:
			walk_state.hide()
			attack_state.show()
			Attack_state()

func Move_state():
	var input_movement = Vector2.ZERO
	input_movement.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_movement.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_movement != Vector2.ZERO:
		spell.knockback_vector = input_movement
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Attack/blend_position", input_movement)
		anim_state.travel("Walk")
		velocity += input_movement * speed
		velocity = velocity.clamped(speed)
	else:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_attack"):
		state = ATTACK
	
	move_and_slide(velocity)	

func Attack_state():
	velocity = Vector2.ZERO
	anim_state.travel("Attack")

func Attack_finished():
	walk_state.show()
	state = MOVE
