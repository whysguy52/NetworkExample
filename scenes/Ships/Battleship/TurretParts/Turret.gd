extends Spatial

var role

var laserSpawn

var gunCast = RayCast
var defaultTarget
var base
var pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	
	if role != "gunner":
		return
	
	#Gun objects - ray cast (to match direction), base and pivot
	gunCast = owner.get_node("GunnerControls/CameraOrbit/CameraNod/Camera/RayCast")
	defaultTarget = owner.get_node("GunnerControls/CameraOrbit/CameraNod/Camera/TargetPoint")
	base = get_node("Base")
	pivot = get_node("Base/PivotPoint")
	
	#laser for shooting
	laserSpawn = $Base/PivotPoint/LaserSpawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	follow_camera()
	
	if Input.is_action_just_pressed("LMB"):
		laserSpawn.fire()

func follow_camera():
	#var vectorTo =  defaultTarget.global_transform.origin - pivot.global_transform.origin
	pivot.global_transform = pivot.global_transform.looking_at(defaultTarget.global_transform.origin,Vector3(0,1,0))
	pivot.global_transform.orthonormalized()
	
	
	
