extends Node2D

signal start_pressed
signal settings_pressed
signal store_pressed

var log_awake = false
var move_factor = 1

func _ready() -> void:
	$lblHighScore.text = "High Score: " + str(PlayerStats.high_score)
	$lblHighScore.text += "\nPoints: " + str(PlayerStats.points)
	
	$Log.texture = load("res://Sprites/Player/Player_" + str(PlayerStats.selected_skin) + ".png")

func _process(delta: float) -> void:
	if not log_awake:
		return
	
	$Exclamation.position.y -= 200 * delta * move_factor
	move_factor -= delta * 3
	
	
func _on_btnPlay_pressed() -> void:
	$Timer.start()
	$Sprite.frame += 1
	log_awake = true
	$Exclamation.visible = true

func _on_Timer_timeout() -> void:
	emit_signal("start_pressed")

func _on_btnSettings_pressed() -> void:
	emit_signal("settings_pressed")

func _on_btnStore_pressed() -> void:
	emit_signal("store_pressed")
