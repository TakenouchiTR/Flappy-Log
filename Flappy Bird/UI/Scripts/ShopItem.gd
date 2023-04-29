extends Control

signal item_selected
signal item_purchased

enum MODE {
	BUY,
	SELECT,
}
const NORMAL_BACKGROUND = Color(205, 239, 246)

var mode = MODE.BUY
var index = 0

func set_select_mode():
	mode = MODE.SELECT
	$btnInteract.text = "Select"

func enable():
	$btnInteract.disabled = false

func disable():
	$btnInteract.disabled = true

func set_price(price):
	$lblPrice.text = "Price: " + str(price)

func set_name_text(name):
	$lblName.text = name

func set_index(index):
	self.index = index
	$picPreview.texture = load("res://Sprites/Player/Player_" + str(index) + ".png")


func _on_btnInteract_pressed() -> void:
	if mode == MODE.BUY:
		emit_signal("item_purchased", index)
	elif mode == MODE.SELECT:
		emit_signal("item_selected", index)
