extends "res://Entities/Ship/Ship.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var hum = $UFOHum
onready var crash = $CrashSound

var velocityLastFrame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var v = linear_velocity.length()
	hum.pitch_scale = max(1, v / 250)
	velocityLastFrame = v

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_collision(body):
	print(velocityLastFrame)
	if velocityLastFrame > 350:
		print("Crash!")
		crash.play()
	pass # Replace with function body.
