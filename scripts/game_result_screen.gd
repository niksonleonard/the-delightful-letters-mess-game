extends Control

@onready var gameSession: GameSessionState = get_node("/root/GameSession")
@export var scoreLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel.text = str(gameSession.score)

func _on_button_startgame_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/main_screen.tscn")
	print("Starting game")


func _on_title_screen_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/title_screen.tscn")
	print("Starting game")
