extends Node

const FILEPATH := "user://data.sav"
const VERSION := 1

func save_file():
	var file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	
	file.store_32(VERSION)
	
	FileIO.save_int_array(file, PlayerStats.high_scores)
	FileIO.save_int_array(file, PlayerStats.unlocked_levels)
	FileIO.save_int_array(file, PlayerStats.unlocked_skins)
	
	file.store_32(PlayerStats.points)
	
	file.store_32(int(PlayerStats.jump_on_release))
	file.store_32(int(PlayerStats.selected_skin))
	file.close()

func load_file():
	
	if not FileAccess.file_exists(FILEPATH):
		return

	var file = FileAccess.open(FILEPATH, FileAccess.READ)
	var version = file.get_32()
	
	match (version):
		1: load_ver_1(file)
	
	file.close()

func load_ver_1(file):
	var high_scores: Array[int] = FileIO.load_int_array(file)
	var unlocked_levels: Array[bool] = FileIO.load_bool_array(file)
	var unlocked_skins: Array[bool] = FileIO.load_bool_array(file)
	var points: int = file.get_32()
	var jump_on_release := bool(file.get_32())
	var selected_skin: int = file.get_32()
	
	PlayerStats.high_scores = high_scores
	PlayerStats.unlocked_levels = unlocked_levels
	PlayerStats.unlocked_skins = unlocked_skins
	PlayerStats.points = points
	PlayerStats.jump_on_release = jump_on_release
	PlayerStats.selected_skin = selected_skin
