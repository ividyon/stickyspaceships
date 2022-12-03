extends "res://Entities/Modules/Bridge/BridgeCore.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var joint = $"../CameraJoint"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate(ship):
	.activate(ship)
	ship.bridge = self
#	joint.set_node_a(get_path_to(ship))
	
func _physics_process(delta):
	._physics_process(delta)

	var move_forward = Input.is_action_pressed("input_up")
	var move_backward = Input.is_action_pressed("input_down")
	var move_left = Input.is_action_pressed("input_left")
	var move_right = Input.is_action_pressed("input_right")
	var turn_left = Input.is_action_pressed("input_turnleft")
	var turn_right = Input.is_action_pressed("input_turnright")
	var brake = Input.is_action_pressed("input_brake")

	forward_impulse = 0
	strafe_impulse = 0
	turn_impulse = 0
	brake_impulse = 0

	if brake or (move_forward and move_backward):
		brake_impulse = 1
		return

	if move_forward and not move_backward:
		forward_impulse = 1
	elif move_backward and not move_forward:
		forward_impulse = -1
		
	if move_right and not move_left:
		strafe_impulse = 1
	elif move_left and not move_right:
		strafe_impulse = -1
		
	if turn_right and not turn_left:
		turn_impulse = 1
	elif turn_left and not turn_right:
		turn_impulse = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
