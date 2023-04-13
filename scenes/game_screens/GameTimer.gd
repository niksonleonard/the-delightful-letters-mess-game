extends Timer
@export var hourlass: Label
var countdown = 30
var timer = 1.0 # tempo em segundos para cada contagem regressiva
var current_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	current_time += delta
	hourlass.text = str(countdown)
	if current_time >= timer:
		current_time = 0.0
		countdown -= 1

