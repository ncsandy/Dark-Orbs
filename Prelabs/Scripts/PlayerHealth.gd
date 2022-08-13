extends Node2D

var bar_red = preload("res://UI/barHorizontal_red.png")
var bar_green = preload("res://UI/barHorizontal_green.png")
var bar_yellow = preload("res://UI/barHorizontal_yellow.png")

onready var healthbar = $HealthBar
onready var label = $Label
onready var labelName = $LabelName

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health
		
func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value / healthbar.max_value * 100 < 70:
		healthbar.texture_progress = bar_yellow
	if value / healthbar.max_value * 100 < 25:
		healthbar.texture_progress = bar_red
	healthbar.value = value
	
func update_name(name):
	labelName.text = str(name)
	
