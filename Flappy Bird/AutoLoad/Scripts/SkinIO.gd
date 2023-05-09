extends Node

const FILEPATH := "res://Data/skins.txt"

# File format:
# Name
# Price
# Sprite Number
# Border Color
# Bark Color
# Sapwood Color
# Heartwood Color
# Outer Ring Color
# Inner Ring Color

func load_file():
	if not FileAccess.file_exists(FILEPATH):
		return

	Skins.skins.clear()
	
	var file = FileAccess.open(FILEPATH, FileAccess.READ)
	
	while not file.eof_reached():
		var line := file.get_csv_line("|")
		if line[0] == "":
			break
		
		var player_skin = Skins.PlayerSkin.new()
		
		player_skin.wood_name = line[0]
		player_skin.shop_price = int(line[1])
		player_skin.sprite_number = int(line[2])
		player_skin.border_color = Color(line[3])
		player_skin.bark_color = Color(line[4])
		player_skin.sapwood_color = Color(line[5])
		player_skin.heartwood_color = Color(line[6])
		player_skin.outer_ring_color = Color(line[7])
		player_skin.inner_ring_color = Color(line[8])
		
		Skins.skins.append(player_skin)
