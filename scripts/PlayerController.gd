extends CharacterBody3D

var holdingLetter: bool = false
@onready var gameSession: GameSessionState = get_node("/root/GameSession")

@export var scoretext: Label

# NavigationAgent3D it is a node that help us to find paths easily
# for reference see: 
# https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_3d.html
@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D

## Speed that player moves
var Speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# Collision detection for touching letters
	# in this peace of code we find out if it touched a Letter
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		# If the collision is with ground
		if (collision.get_collider() == null):
			continue
		
		# Get in current Loop index the collision information
		var collider = collision.get_collider()
		# Check if touched some letter
		if collider.is_in_group(GameSessionState.LETTERS_GROUP):
			collectTheLetter(collider)
			continue

		# Check if touched delivery office
		if collider.is_in_group(GameSessionState.DELLIVERYPOST_GROUP):
			delliveryLetterInPost()
			continue
	
	if(navigationAgent.is_navigation_finished()):
		return
	# deal with character movement
	moveToPoint(delta, Speed)

## When player touches a letter on the floor before the antagonist
func collectTheLetter(collider):
	holdingLetter = true
	gameSession.add_score(10, GameSessionState.ScoreReason.DeliveredLetter)
	scoretext.text="Pontos:"+ str(gameSession.score)
	print("I take a letter " + str(gameSession.score))
	$CollectAudio.play()
	collider.queue_free()
	gameSession.picked_letter()

## When player has catch a letter and touches a deliverry office
func delliveryLetterInPost():
	if(holdingLetter==true):
		gameSession.add_score(20, GameSessionState.ScoreReason.DeliveredLetter)
		scoretext.text="Pontos:"+ str(gameSession.score)
		holdingLetter = false
		$DelliveryAudio.play()
		gameSession.delivered_letter()

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

		# The following stuff it is about Trigonometry, we must to calculate
		# where is the point clicked from the camera view that is
		# in the floor
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		var mousePos = get_viewport().get_mouse_position()

		# ray is the way we calculate the point, it is like we shot a 
		# imaginary ray from the camera and detects what it instersects
		var rayLength = 100
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		rayQuery.collide_with_areas = true

		# here is the result of ray insersection found
		var result = space.intersect_ray(rayQuery)
		if result:
			navigationAgent.target_position = result.position

## Represents all the proccess that must be done when touch a letter
func holdTheFoundLetter(letter: Object):
	# For now just destroy the letter
	letter.queue_free()


