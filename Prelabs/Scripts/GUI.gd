extends CanvasLayer

onready var health_display  = $PlayerHealth/HealthBar
onready var health_script  = $PlayerHealth
onready var health_label = $PlayerHealth/Label

func _process(_delta):
	$OrbsLabel.text = str(Globals.orbs)	
	
func _ready():
	health_display.max_value = Globals.player_max_health
	health_label.text = str(Globals.player_health, " / ", Globals.player_max_health)

