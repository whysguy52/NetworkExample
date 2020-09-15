extends KinematicBody


var shipPosition
var role
var maxSpeed = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	shipPosition = $ShipBody

func _physics_process(delta):
	if role != "pilot":
		return
	move_ship_forward(delta)

func move_ship_forward(delta):
	move_and_slide(shipPosition.transform.basis.x.normalized() * maxSpeed)
