extends Node

## Saves an array as an array of integers. Used to store int and bool arrays.
func save_int_array(file, array):
	file.store_32(len(array))
	for item in array:
		file.store_32(int(item))

## Loads an array of bools
func load_bool_array(file) -> Array[bool]:
	var length = file.get_32()
	var array: Array[bool] = []
	for i in range(length):
		array.append(bool(file.get_32()))
	return array

## Loads an array of ints
func load_int_array(file) -> Array[int]:
	var length = file.get_32()
	var array: Array[int] = []
	for i in range(length):
		array.append(file.get_32())
	return array
