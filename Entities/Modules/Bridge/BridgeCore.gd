extends "res://Entities/Modules/ModuleCore.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var forward_impulse: int = 0
var turn_impulse: int = 0
var strafe_impulse: int = 0
var fire_impulse: int = 0
var brake_impulse: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	pass

func activate(ship):
	.activate(ship)
	ship.bridge = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
