extends Node3D

# Reference to wich scene create (a link  to Letter Object)
@export var letter_object_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$CreateLetterTimer.timeout.connect(createLetterInstance)

func createLetterInstance():
	# Create a new letter
	var letter = letter_object_scene.instantiate()

	# Add it to the scene
	add_child(letter)

	# Restart the timer
	$CreateLetterTimer.start(2)