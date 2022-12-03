extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var core = $ModuleCore
onready var collision: CollisionPolygon2D
onready var polygon: Polygon2D

enum MODULE_TYPE { MODULE, SUBMODULE }
export(MODULE_TYPE) var module_type = MODULE_TYPE.MODULE

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is CollisionPolygon2D:
			collision = child
			break

	for child in get_children():
		if child is Polygon2D:
			polygon = child
			break

	if polygon && collision:
		# Apply the visible polygon to the collision polygon to avoid having to maintain two.
		collision.polygon = Transform2D(0, polygon.offset).xform(polygon.polygon)

	random_color()

func random_color():
	randomize();

	var red = rand_range(0.2, 1);
	var green = rand_range(0.2, 1);
	var blue = rand_range(0.2, 1);

	polygon.color.r = red;
	polygon.color.g = green;
	polygon.color.b = blue;

func install_on_ship(ship):
	core.activate(ship)
	remove_child(core)
	core.transform = transform
	ship.activeModules.add_child(core)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
