extends Control

@onready var gameSession: GameSessionState = get_node("/root/GameSession")
@export var scoreLabel: Label
@export var ladyBugLetters: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	_final_letter_text()
	scoreLabel.text = str(gameSession.score)
	gameSession.save_player_data()
	

func _on_button_startgame_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/game_preparation_screen.tscn")
	print("Starting game")


func _on_title_screen_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/title_screen.tscn")
	print("Starting game")

# Called in the game over and selects the correct sentence to use singular and plural rules
func _final_letter_text():
	if gameSession.eatenLetters != 1 and gameSession.pickedLetters == 1:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " cartas \nVocê pegou " + str(gameSession.pickedLetters) + " carta"
	elif gameSession.eatenLetters == 1 and gameSession.pickedLetters != 1:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " carta \nVocê pegou " + str(gameSession.pickedLetters) + " cartas"
	else:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " cartas \nVocê pegou " + str(gameSession.pickedLetters) + " cartas"