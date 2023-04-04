extends CharacterBody3D

# NavigationAgent3D it is a node that help us to find paths easily
# for reference see: 
# https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_3d.html
@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D
var Speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(navigationAgent.is_navigation_finished()):
		return
	
	# deal with character movement
	moveToPoint(delta, Speed)

func moveToPoint(_delta, speed):
	var targetPos = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	faceDirection(targetPos)
	velocity = direction * speed
	move_and_slide()

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func _input(_event):
	# Check if the player performed a click 
	if Input.is_action_just_pressed("PointClick"):
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 100
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		rayQuery.collide_with_areas = true
		var result = space.intersect_ray(rayQuery)
		print(result)
		
		navigationAgent.target_position = result.position
