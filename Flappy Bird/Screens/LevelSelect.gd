extends "res://Screens/Scripts/Screen.gd"

const _MAIN_MENU := preload("res://Screens/Menu.tscn")
const _LEVEL_NAMES := [
	"The Beginning",
	"Forest Run",
]

@onready var _level_name_label = $Control/LevelNameLabel
@onready var _high_score_label = $Control/HighScoreLabel

var _levels := [
	load("res://Screens/Levels/PollenLevel.tscn"),
	load("res://Screens/Levels/ForestLevel.tscn"),
]
var _selected_level = 0

func _ready():
	_update_selected_level(PlayerStats.last_level_selected)

func _update_selected_level(index: int):
	_selected_level = index
	_level_name_label.text = _LEVEL_NAMES[index]
	_high_score_label.text = "High score: " + str(PlayerStats.high_scores[index])

func _on_start_button_pressed():
	PlayerStats.last_level_selected = _selected_level
	screen_closed.emit(_levels[_selected_level].instantiate())


func _on_back_button_pressed():
	screen_closed.emit(load("res://Screens/Menu.tscn").instantiate())


func _on_next_level_button_pressed():
	if _selected_level < len(_LEVEL_NAMES) - 1:
		_update_selected_level(_selected_level + 1)


func _on_prev_level_button_pressed():
	if _selected_level > 0:
		_update_selected_level(_selected_level - 1)
