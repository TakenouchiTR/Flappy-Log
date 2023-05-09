extends Node

## How many points the player has to spend in the shop.
var points = 0

## Which skins the player has unlocked.
var unlocked_skins : Array[bool] = [
	true,
	false,
	false,
]

## The skin that the player has selected.
var selected_skin := 0

## Which levels the player has unlocked.
var unlocked_levels: Array[bool] = [
	true,
	false,
]

## The last level that the player played this session.
var last_level_selected := 0

## The high scores for each level.
var high_scores := [
	0,
	0,
]

## Whether the player should jump when their finger is lefted from the screen.
var jump_on_release := false
