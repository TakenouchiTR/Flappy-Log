extends "Falling Object.gd"

export var texture_name = ""
export var file_extension = ".png"

func _ready() -> void:
	texture = load(texture_name + str(PlayerStats.selected_skin) + file_extension)
