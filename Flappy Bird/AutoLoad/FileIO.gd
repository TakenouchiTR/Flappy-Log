extends Node

const FILEPATH = "user://data.sav"
const VERSION = 2

func save_file():
	var file = File.new()
	
	file.open(FILEPATH, File.WRITE)
	file.store_32(VERSION)
	file.store_32(PlayerStats.high_score)
	file.store_32(PlayerStats.points)
	file.store_32(len(PlayerStats.unlocked_skins))
	for i in range(len(PlayerStats.unlocked_skins)):
		file.store_32(int(PlayerStats.unlocked_skins[i]))
	file.store_32(int(PlayerStats.jump_on_release))
	file.store_32(int(PlayerStats.selected_skin))
	file.close()

func load_file():
	var file = File.new()
	
	if not file.file_exists(FILEPATH):
		return

	file.open(FILEPATH, File.READ)
	var version = file.get_32()
	
	match (version):
		1: load_ver_1(file)
		2: load_ver_2(file)
	
	file.close()

func load_ver_1(file):
	var high_score = file.get_32()
	var points = file.get_32()
	PlayerStats.high_score = high_score
	PlayerStats.points = points
	var skin_count = file.get_32()
	for i in range(skin_count):
		var skin_unlocked = bool(file.get_32())
		PlayerStats.unlocked_skins[i] = skin_unlocked

func load_ver_2(file):
	load_ver_1(file)
	var jump_on_release = bool(file.get_32())
	PlayerStats.jump_on_release = jump_on_release
	var selected_skin = file.get_32()
	PlayerStats.selected_skin = selected_skin
