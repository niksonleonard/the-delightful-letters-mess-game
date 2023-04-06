extends CharacterBody3D

@onready var navigationAgent: NavigationAgent3D = $NavigationAgent3D

const LETTERS_GROUP = "letters"

var Speed = 5

func _letter_touched_floor(target_position: Vector3):
	if navigationAgent.is_navigation_finished():
		navigationAgent.target_position = target_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	# Move the character if it still has to
	if(!navigationAgent.is_navigation_finished()):
		moveToPoint()
	
	# Collision detection for touching letters
	# in this peace of code we find out if it touched a Letter
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		# If the collision is with ground
		if (collision.get_collider() == null):
			continue

		var collider = collision.get_collider()
	
		if collider.is_in_group(LETTERS_GROUP):
			print("Wow, found some thing")
			eatTheFoundLetter(collider)
			continue
				
func moveToPoint():
	var targetPos = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	# faceDirection(targetPos)
	velocity = direction * Speed
	move_and_slide()

## Represents all the proccess that must be done when touch a letter
func eatTheFoundLetter(letter: Object):
	$AudioStreamPlayer3D.play()
	print("Nhaaac!")

	# For now just destroy the letter
	global_position = letter.global_position
	letter.queue_free()

	# After ate tryies to find another one
	findAnotherLetter()

func findAnotherLetter():
	var letters = get_tree().get_nodes_in_group(LETTERS_GROUP)
	if letters.size() == 0:
		print("Nothing new to eat!")
		return

	for letter in letters:
		if (letter.is_queued_for_deletion()):
			continue

		print("Next one please", letter.global_position)
		navigationAgent.target_position = letter.global_position
