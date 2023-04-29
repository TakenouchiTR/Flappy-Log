extends Node2D

const FRONT_LOG_HALF = preload("res://Entities/Front Log Half.tscn")
const BACK_LOG_HALF = preload("res://Entities/Back Log Half.tscn")  

signal game_ended
signal game_restarted

onready var lbl_score = $lblScore
onready var player = $Player
var score = 0

func _ready() -> void:
	for obstacle in $Obstacles.get_children():
		obstacle.connect("score_area_entered", self,\
			"_on_Obstacle_score_area_entered")
		obstacle.connect("kill_area_entered", self,\
			"_on_Obstacle_kill_area_entered")

func update_stats():
	PlayerStats.points += score
	PlayerStats.high_score = max(PlayerStats.high_score, score)

func _on_Obstacle_score_area_entered() -> void:
	score += 1
	lbl_score.text = "Score: " + str(score)

func _on_Obstacle_kill_area_entered(area = null) -> void:
	update_stats()
	FileIO.save_file()
	
	var front_log = FRONT_LOG_HALF.instance()
	var back_log = BACK_LOG_HALF.instance()
	
	back_log.velocity.y = player.velocity.y - 32
	back_log.rotation_offset = 32
	front_log.velocity.y = player.velocity.y
	front_log.velocity.x += 16
	
	if player.velocity.y > 400:
		front_log.rotation_offset -= player.velocity.y - 400
		back_log.rotation_offset -= player.velocity.y - 400
	
	add_child(front_log)
	add_child(back_log)
	
	move_child(front_log, 3)
	move_child(back_log, 1)
	
	front_log.position = player.position
	back_log.position = player.position
	
	player.queue_free()
	
	for obstacle in $Obstacles.get_children():
		obstacle.move_speed = 0
	$Background.moving = false
	$btnReturn.visible = true
	$btnRestart.visible = true


func _on_btnReturn_pressed() -> void:
	emit_signal("game_ended")


func _on_btnRestart_pressed() -> void:
	emit_signal("game_restarted")


func _on_KillBox_area_entered() -> void:
	pass # Replace with function body.
