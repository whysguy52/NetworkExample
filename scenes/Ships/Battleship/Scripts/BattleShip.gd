extends Spatial


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
	moveShipForward(delta)

func moveShipForward(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
