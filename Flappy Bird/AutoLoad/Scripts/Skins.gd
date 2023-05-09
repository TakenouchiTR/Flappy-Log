extends Node

const PALETTE_SIZE = 16
const BARK_COLOR_INDEX := 0
const SAPWOOD_COLOR_INDEX := 1
const HEARTWOOD_COLOR_INDEX := 2
const RING_COLOR_INDEX := 3

class PlayerSkin:
	var wood_name: String
	var shop_price: int
	var sprite_number: int
	var border_color: Color
	var bark_color: Color
	var sapwood_color: Color
	var heartwood_color: Color
	var outer_ring_color: Color
	var inner_ring_color: Color
	
	func to_color_palette() -> PackedColorArray:
		var palette: Array[Color] = []
		palette.resize(PALETTE_SIZE)
		palette.fill(Color(0, 0, 0, 1))
		
		palette[0] = border_color
		palette[1] = bark_color
		palette[2] = sapwood_color
		palette[3] = heartwood_color
		palette[4] = outer_ring_color
		palette[5] = inner_ring_color
		
		return PackedColorArray(palette)

var skins: Array[PlayerSkin] = []
