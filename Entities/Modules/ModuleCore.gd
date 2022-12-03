extends Node2D

onready var shell = get_parent()

var host_ship

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func activate(ship):
	host_ship = ship
	for child in shell.get_children():
		if child != self:
			shell.remove_child(child)
			add_child(child)
			if child is Polygon2D:
				child.visible = false
			if child is CollisionPolygon2D:
				child.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
