extends Node3D

# imports the Game Session Singleton to a variable
@onready var gameSession: GameSessionState = get_node("/root/GameSession")

# Reference to wich scene create (a link  to Letter Object)
@export var letter_object_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$CreateLetterTimer.timeout.connect(createLetterInstance)

func createLetterInstance():
	# Create a new instance of the Mob scene.
	var letter = letter_object_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("Path3D/PathFollow3D")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	letter.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(letter)

	# Register to game session that a new brand beaultiful letter was created
	gameSession.created_letter()
