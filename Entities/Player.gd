extends Camera2D

# Declare member variables here.
var ship

# Called when the node enters the scene tree for the first time.
func _ready():
	# Apply the visible polygon to the collision polygon to avoid having to maintain two.
	ship = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
