extends "res://Screens/Scripts/Screen.gd"

signal store_closed

const STORE_ITEM = preload("res://UI/ShopItem.tscn")
const Y_OFFSET = 175
const PADDING = 200
const PRICES = [
	0,
	20,
	75,
]
const NAMES = [
	"Cherry",
	"Cedar",
	"Walnut",
]

@onready var store_items = $StoreItems

func _ready() -> void:
	display_points()
	for i in range(len(PlayerStats.unlocked_skins)):
		var store_item = STORE_ITEM.instantiate()
		store_items.add_child(store_item)
		store_item.position.y = i * PADDING + Y_OFFSET
		store_item.set_price(PRICES[i])
		store_item.set_name_text(NAMES[i])
		store_item.set_index(i)
		store_item.connect("item_purchased", Callable(self, "on_item_purchased"))
		store_item.connect("item_selected", Callable(self, "on_item_selected"))
	
	set_item_statuses()

func display_points():
	$lblPoints.text = "Points: " + str(PlayerStats.points)

func set_item_statuses():
	var items = store_items.get_children()
	for i in range(len(items)):
		var item = items[i]
		if PlayerStats.selected_skin == i:
			item.set_select_mode()
			item.disable()
		elif PlayerStats.unlocked_skins[i]:
			item.set_select_mode()
			item.enable()
		elif PlayerStats.points < PRICES[i]:
			item.disable()

func on_item_purchased(index):
	PlayerStats.points -= PRICES[index]
	PlayerStats.unlocked_skins[index] = true
	display_points()
	set_item_statuses()
	
func on_item_selected(index):
	PlayerStats.selected_skin = index
	set_item_statuses()

func _on_btnMenu_pressed() -> void:
	PlayerIO.save_file()
	screen_closed.emit(load("res://Screens/Menu.tscn").instantiate())
