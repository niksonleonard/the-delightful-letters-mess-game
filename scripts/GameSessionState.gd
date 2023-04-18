extends Node
class_name GameSessionState

# For more understanding of the use of it patter singleton:
# https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html

# Nodes Groups keys, mustly used to detects collision
const LETTERS_GROUP = "letters"
const DELLIVERYPOST_GROUP = "delliverypost"

## It indicates possibles ways the player could get it scores
enum ScoreReason {
    PickedLetter,
    DeliveredLetter
}

signal score_changed
signal letter_picked
signal letter_dellivered

## Level created letters
## In the future it could be used to calculate a better score or something
var levelCreatedLetters: int = 0

## Player score make in the current
var score: int = 0

## Recovery lettlers
var pickedLetters: int = 0

## Deliveried lettlers
var deliveredLetters: int = 0

## Eaten letterls
var eatenLetters: int = 0

var playerData: PlayerData

func _ready():
    playerData = ResourceLoader.load(PlayerData.PLAYERDATA_PATH)
    if !playerData:
        playerData = PlayerData.new()
        ResourceSaver.save(playerData, PlayerData.PLAYERDATA_PATH)
    print(playerData)

## Registers some score attributed to the player
func add_score(score_value: int, _score_reason: ScoreReason):
    score += score_value
    score_changed.emit()

## Registers each letter that was created in the current session
func created_letter():
    levelCreatedLetters += 1

## Register when an antagonist eats a letter
func eaten_letter():
    eatenLetters += 1

## Register when the player successfuly collect a letter from the floor
func picked_letter():
    pickedLetters += 1
    letter_picked.emit()

## Register when the player successfuly delivery to a post office
func delivered_letter():
    deliveredLetters += 1
    letter_dellivered.emit()

func reset_gamedata():
    score = 0
    pickedLetters = 0
    deliveredLetters = 0
    eatenLetters = 0
    levelCreatedLetters = 0

func tutorial_done():
    playerData.tutorialCompletedTimes += 1
    save_player_data()

func save_player_data():
    ResourceSaver.save(playerData, PlayerData.PLAYERDATA_PATH)