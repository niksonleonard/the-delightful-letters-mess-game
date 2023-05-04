extends RigidBody3D

## if the wind force is apply at the same position in the letter it
## do not apply a floating like effects
var lastPressurePoint: Vector3 = Vector3(2, 0 ,0)

## if the letter already has touched the floor
var isOnTheFloor: bool = false

func _ready():
	$WindTimer.timeout.connect(_applyWindForce)

## Signal calls it whe touch something
func _on_body_entered(_body:Node):
	isOnTheFloor = true
	get_tree().call_group("joaninha", "_letter_touched_floor", global_position)

func _applyWindForce():
	# Check if the letter already touched the floor
	# if so stops the wind timer and stop this function
	if (isOnTheFloor):
		$WindTimer.stop()
		return

	# To invert the pressure point vector
	lastPressurePoint = -1 * lastPressurePoint

	# apply wind force at the pressure point
	apply_force(Vector3(0, .3, 0), lastPressurePoint)


