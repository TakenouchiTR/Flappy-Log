extends "res://Entities/Obstacles/Scripts/Obstacle.gd"

signal flower_entered

func _on_win_area_entered(_area):
	flower_entered.emit()
