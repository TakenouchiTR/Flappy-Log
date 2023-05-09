extends "res://Screens/Scripts/Screen.gd"

@onready var high_score_label := $CanvasLayer/Control/lblHighScore

var log_awake = false
var move_factor = 1

func _ready() -> void:
	high_score_label.text = "High Score: " + str(PlayerStats.high_scores[1])
	high_score_label.text += "\nPoints: " + str(PlayerStats.points)
	
	$Log.texture = load("res://Sprites/Player/Player_" + str(PlayerStats.selected_skin) + ".png")

func _process(delta: float) -> void:
	if not log_awake:
		return
	
	$Exclamation.position.y -= 200 * delta * move_factor
	move_factor -= delta * 3
	
	
func _on_btnPlay_pressed() -> void:
	$Timer.start()
	$Sprite2D.frame += 1
	log_awake = true
	$Exclamation.visible = true

func _on_Timer_timeout() -> void:
	screen_closed.emit(load("res://Screens/LevelSelect.tscn").instantiate())

func _on_btnSettings_pressed() -> void:
	screen_closed.emit(load("res://Screens/Settings.tscn").instantiate())

func _on_btnStore_pressed() -> void:
	screen_closed.emit(load("res://Screens/Store.tscn").instantiate())
