extends Spatial

#Camera parts
var cameraOrbit
var cameraNod

#Gun parts
var gun1Orbit
var gun2Orbit
var gun1Nod
var gun2Nod
var laserSpawn1
var laserSpawn2
var turrets = []

var role

var MOUSE_SENSITIVITY = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	
	gun1Orbit = get_parent().get_node("ShipBody/GunController/Gun1/Base")
	gun2Orbit = get_parent().get_node("ShipBody/GunController/Gun2/Base")
	
	gun1Nod = get_parent().get_node("ShipBody/GunController/Gun1/Base/PivotPoint")
	gun2Nod = get_parent().get_node("ShipBody/GunController/Gun2/Base/PivotPoint")
	
	laserSpawn1 = get_parent().get_node("ShipBody/GunController/Gun1/Base/PivotPoint/LaserSpawn")
	laserSpawn2 = get_parent().get_node("ShipBody/GunController/Gun2/Base/PivotPoint/LaserSpawn")
	
	turrets.append(laserSpawn1)
	turrets.append(laserSpawn2)
	if role != "gunner":
		return
	$CameraOrbit/CameraNod/Camera.make_current()
	cameraOrbit = $CameraOrbit
	cameraNod = $CameraOrbit/CameraNod
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if role != "gunner":
		return
	process_input(delta)

func process_input(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("LMB"):
		for turret in turrets:
			turret.fire()

func _input(event):
	if role != "gunner":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_all(event)

remote func _turret_rotation(gun1OrbitAngle, gun1NodAngle, gun2OrbitAngle, gun2NodAngle):
	#THIS NEEDS TO BE REDONE!!! 
	gun1Orbit.global_transform = gun1OrbitAngle
	gun1Nod.global_transform = gun1NodAngle
	
	gun2Orbit.global_transform = gun2OrbitAngle
	gun2Nod.global_transform = gun2NodAngle
	

func rotate_all(event):
	cameraOrbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	
	gun1Orbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	gun1Nod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	
	gun2Orbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	gun2Nod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	
	rpc(
		"_turret_rotation",
		cameraOrbit.global_transform,
		cameraNod.global_transform, 
		gun2Orbit.global_transform, 
		gun2Nod.global_transform
	)
