extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var collision = $CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Polygon2D:
			# Apply the visible polygon to the collision polygon to avoid having to maintain two.
			collision.polygon = Transform2D(0, child.offset).xform(child.polygon)
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
