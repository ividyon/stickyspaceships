extends RigidBody2D

const BridgeCore = preload("res://Entities/Modules/Bridge/BridgeCore.gd")
const Module = preload("res://Entities/Modules/Module.gd");

# Declare member variables here. Examples:
onready var initialModules: Node2D = $InitialModules
onready var activeModules: Node2D = $ActiveModules
onready var polygons: Node2D = $ActivePolygons
var bridge: BridgeCore

export var Torque: int = 10000
export var Thrust: int = 300

var currentTorque = Torque
var currentThrust = Thrust

# Called when the node enters the scene tree for the first time.
func _ready():
	for module in initialModules.get_children():
		module.install_on_ship(self)
	assemble_polygons()
	assemble_collision()

func assemble_polygons():
	for polygon in polygons.get_children():
		if polygon is Polygon2D:
			polygons.remove_child(polygon)
			
	for module in activeModules.get_children():
		for modulePolygon in module.get_children():
			if !(modulePolygon is Polygon2D):
				continue
			var newPolygon = modulePolygon.duplicate(15) 
			newPolygon.visible = true
#			var newPolygon = Polygon2D.new()
#			newPolygon.polygon = modulePolygon.polygon
#			newPolygon.offset = modulePolygon.offset
#			newPolygon.color = modulePolygon.color
			newPolygon.transform = module.transform
#			newPolygon.texture = modulePolygon.texture
#			newPolygon.texture_offset = modulePolygon.texture_offset
			polygons.add_child(newPolygon)
			break

func assemble_collision():
	for collision in get_children():
		if collision is CollisionPolygon2D:
			remove_child(collision)

	for module in activeModules.get_children():
		for moduleCollision in module.get_children():
			if !(moduleCollision is CollisionPolygon2D):
				continue
			var newCollision = moduleCollision.duplicate()
			newCollision.disabled = false
#			var newCollision = CollisionPolygon2D.new()
#			newCollision.polygon = moduleCollision.polygon
			newCollision.transform = module.transform
			add_child(newCollision)
			break

func _integrate_forces(state: Physics2DDirectBodyState):
	if not bridge:
		return
	
	var buffered_force: Vector2 = Vector2(0, 0)
	var rotation_dir: int = 0
	angular_damp = -1
	linear_damp = -1

	if bridge.brake_impulse > 0:
		angular_damp = currentThrust / 100
		linear_damp = currentThrust / 100
	else:
		angular_damp = -1
		linear_damp = -1
		if bridge.forward_impulse > 0:
			buffered_force.x = currentThrust
		elif bridge.forward_impulse < 0:
			buffered_force.x = -currentThrust

		if bridge.strafe_impulse > 0:
			buffered_force.y = currentThrust
		elif bridge.strafe_impulse < 0:
			buffered_force.y = -currentThrust
			
		if bridge.turn_impulse > 0:
			rotation_dir += 1
		elif bridge.turn_impulse < 0:
			rotation_dir -= 1

	applied_force = buffered_force.rotated(rotation)
	applied_torque = rotation_dir * currentTorque
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
