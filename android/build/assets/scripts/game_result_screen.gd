extends Control

@onready var gameSession: GameSessionState = get_node("/root/GameSession")
@export var scoreLabel: Label
@export var ladyBugLetters: Label

@export var newRecordPanel: VBoxContainer
@export var displayName: TextEdit

var _callback_ref = JavaScriptBridge.create_callback(_check_global_record)

# Called when the node enters the scene tree for the first time.
func _ready():
	_final_letter_text()
	scoreLabel.text = str(gameSession.score)
	gameSession.save_player_data()
	if OS.has_feature('web'):
		var window = JavaScriptBridge.get_interface("window")
		window.getRank().then(_callback_ref)

func _on_button_startgame_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/game_preparation_screen.tscn")
	print("Starting game")

func _on_title_screen_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/title_screen.tscn")
	print("Starting game")

func _check_global_record(args):
	var globalRecrodScore = args[0][0].score
	print("Callback is fine:", globalRecrodScore)

	if globalRecrodScore < gameSession.score:
		newRecordPanel.visible = true

# Called in the game over and selects the correct sentence to use singular and plural rules
func _final_letter_text():
	if gameSession.eatenLetters != 1 and gameSession.pickedLetters == 1:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " cartas \nVocê pegou " + str(gameSession.pickedLetters) + " carta"
	elif gameSession.eatenLetters == 1 and gameSession.pickedLetters != 1:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " carta \nVocê pegou " + str(gameSession.pickedLetters) + " cartas"
	else:
		ladyBugLetters.text = "A Joaninha comeu " + str(gameSession.eatenLetters) + " cartas \nVocê pegou " + str(gameSession.pickedLetters) + " cartas"

func _on_button_pressed():
	if displayName.text:
		var window = JavaScriptBridge.get_interface("window")
		window.registerRank(displayName.text, gameSession.score)
		newRecordPanel.visible = false
	else:
		displayName.grab_focus()
