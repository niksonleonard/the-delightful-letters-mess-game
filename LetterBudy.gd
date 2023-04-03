extends RigidBody3D

@export var windTimer: Timer
var lastPressurePoint: Vector3 = Vector3(1, 0 ,0)
var isOnTheFloor: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	windTimer = $Timer
	windTimer.timeout.connect(_applyWindForce)
	

func _applyWindForce():
	if (isOnTheFloor):
		windTimer.stop()
		return

	lastPressurePoint = -1 * lastPressurePoint
	apply_force(Vector3(.1, .2, 0), lastPressurePoint)

func _on_body_shape_entered():
	isOnTheFloor = true
	print("Biluzeira")
