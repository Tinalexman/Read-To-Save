extends Node

var tile_id : Array = [0] # The tilesets present in the tilemap
var level_tilemap : TileMap = null # The tilemap of the level being generated
var level_portal : Area2D = null # The portal that moves the player to the next level
var level_camera : Camera2D = null # The camera of the player

var block_size : int = 80 # The size of a block in pixels

var room_width_per_block : int = 22 # The number of blocks needed to make up a room's width
var room_height_per_block : int = 14 # The number of blocks needed to make up a room's height

var horizontal_rooms_per_level : int = 4 # The number of rooms to make up a level's width
var vertical_rooms_per_level : int = 3 # The number of rooms to make up a level's height

var minimum_enemies_per_room : int = 2 # The minimum number of enemies in a room
var maximum_enemies_per_room : int = 4 # The maximum number of enemies in a room

var minimum_coins_per_room : int = 1 # The minimum number of coins in a room
var maximum_coins_per_room : int = 5 # The maximum number of coins in a room

const multiplier : int = 359 # The row multiplier

const bottom_exit_size : int = 4 # The size, in blocks, of a bottom exit
const side_exit_size : int = 3 # The size, in blocks, of a bottom exit
const side_exit_stump : int = 2 # The height, in blocks, of a side exit from the bottom wall

const room_types : int = 10 # The possible types of room that can be constructed

const tile_eraser : int = -1 # It erases a block tile

const data_path : String = "res://src/room data/" # The path to the room data directory

var assigned_rooms : Array = []
var down_path_rooms : Array = []

var room_data : Array = []
var enemy_data : Array = []
var coin_data : Array = []

var total_rooms : int = 0

func _ready() -> void:
	# Open the room data directory and read all the files
	var directory : Directory = Directory.new()
	var file_names : Array = []
	
	if directory.open(data_path) == OK:
		directory.list_dir_begin(true, true)
		var file_name : String = directory.get_next()
		while file_name != "":
			file_names.append(file_name)
			total_rooms += 1
			file_name = directory.get_next()

		for name in file_names:
			var file : File = File.new()
			file.open(data_path + name, File.READ)
			var coordinates : String = file.get_line()
			var enemies : String = file.get_line()
			var coins : String = file.get_line()
			var data : Array = _process_room(coordinates, enemies, coins)
			room_data.append(data[0])
			enemy_data.append(data[1])
			coin_data.append(data[2])
	
	else:
		printerr("Room Data File not found! Please contact the developer!")

func _process_room(coordinates : String, enemies : String, coins : String) -> Array:
	var data : Array = []
	
	var coords_data : Array = []
	coordinates = coordinates.substr(0, coordinates.length() - 1)
	var string_coordinates : Array = coordinates.split("#")
	for i in range(len(string_coordinates)):
		var number : int = int(string_coordinates[i])
		var row : int = int(number / multiplier)
		var column = number % multiplier
		coords_data.append([row, column])
	
	print(enemies)
	var enemies_data : Array = []
	enemies = enemies.substr(0, enemies.length() - 1)
	var string_enemies : Array = enemies.split("#")
	for i in range(len(string_enemies)):
		var number : int = int(string_enemies[i])
		var row : int = int(number / multiplier)
		var column = number % multiplier
		enemies_data.append([row, column])
		
	var coins_data : Array = []
	coins = coins.substr(0, coins.length() - 1)
	var string_coins : Array = coins.split("#")
	for i in range(len(string_coins)):
		var number : int = int(string_coins[i])
		var row : int = int(number / multiplier)
		var column = number % multiplier
		coins_data.append([row, column])
	
	data.append(coords_data)
	data.append(enemies_data)
	data.append(coins_data)
	
	return data

func create_new_level() -> Array:
	# Seed the random number generator
	randomize()
	
	# This function creates a new level
	assigned_rooms.clear()
	down_path_rooms.clear()
	
	total_rooms = horizontal_rooms_per_level * vertical_rooms_per_level
	for _i in range(total_rooms):
		assigned_rooms.append(false)
	
	# Get the width and height of the level in blocks
	var level_width : int = 1 + (horizontal_rooms_per_level * (room_width_per_block + 1))
	var level_height : int = 1 + (vertical_rooms_per_level * (room_height_per_block + 1))
	
	var offset : int = 0
	
	# Draw the vertical walls of the level
	while offset < level_width:
		for i in range(level_height):
			level_tilemap.set_cell(offset, i, tile_id[0])
		offset += (room_width_per_block + 1)
		
	offset = 0
	
	# Draw the horizontal walls of the level
	while offset < level_height:
		for i in range(level_width):
			level_tilemap.set_cell(i, offset, tile_id[0])
		offset += (room_height_per_block + 1)
	
	for i in range((vertical_rooms_per_level - 1)):
		var row : int = horizontal_rooms_per_level * i
		var index : int = rand_range(row, row + horizontal_rooms_per_level)
		down_path_rooms.append(index)
	
	# Set the camera limits
	level_camera.limit_right = level_width * block_size
	level_camera.limit_bottom = level_height * block_size

	_create_room(0)
	
	return [enemy_data, coin_data]

func _create_room(room_index : int) -> void:
	# If the rooms has already been assigned, skip it
	if assigned_rooms[room_index] == true:
		return
	
	# Get the row and column position of the room in the level
	var row : int = int(room_index / horizontal_rooms_per_level)
	var column : int = room_index % horizontal_rooms_per_level
	
	# Get the neighbors of the room
	var neighbors : Array = _get_neighbors(row, column)
	
	# Draw the room
	_draw_room(row, column)
	assigned_rooms[room_index] = true
	
	# Draw the neighbors
	for index in neighbors:
		_create_room(index)

func _draw_room(row : int, column : int) -> void:
	# Draw the borders of the room
	_draw_room_borders(row, column)
	
	# Draw the contents of the room
	#_draw_random_room_contents()

func _draw_random_room_contents() -> void:
	# Get a random room
	var room_index : int = rand_range(0, total_rooms - 1)
	room_index = 0
	
	# Draw the obstacles in the room
	var coordinates : Array = room_data[room_index]
	for coordinate in coordinates:
		level_tilemap.set_cell(coordinate[0], coordinate[1], tile_id[0])

func _draw_room_borders(row : int, column : int) -> void:
	var walls : Array = _has_both_walls(row, column)
	
	# Check if the room is in the list of down rooms
	if (row * horizontal_rooms_per_level) + column in down_path_rooms:
		var y : int = (row + 1) * (room_height_per_block + 1)
		var x : int = column * (room_width_per_block + 1)
		var difference = room_width_per_block - bottom_exit_size
		x += int(difference * 0.5)
		for i in range(bottom_exit_size):
			level_tilemap.set_cell((x + i), y, tile_eraser)
	
	# Check if the left wall is configurable
	if walls[0]:
		var y : int = row * (room_height_per_block + 1)
		var x : int = column * (room_width_per_block + 1)
		var difference = room_height_per_block - side_exit_size - side_exit_stump
		y += difference
		for i in range(side_exit_size):
			level_tilemap.set_cell(x, (y + i), tile_eraser)
	
	# Check if the right wall is configurable
	if walls[1]:
		var y : int = row * (room_height_per_block + 1)
		var x : int = (column + 1) * (room_width_per_block + 1)
		var difference = room_height_per_block - side_exit_size - side_exit_stump
		y += difference
		for i in range(side_exit_size):
			level_tilemap.set_cell(x, (y + i), tile_eraser)

func _has_both_walls(row : int, column : int) -> Array:
	var walls : Array = [false, false]
	if (row >= 0 and column == 0) or (row <= vertical_rooms_per_level - 1 and column == 0):
		# This room is in the left edge, only the right walls can be configured
		walls[1] = true
	elif (row >= 0 and column == horizontal_rooms_per_level - 1) or (row <= vertical_rooms_per_level - 1 and column == horizontal_rooms_per_level - 1):
		# This room is in the right edge, so only the left walls can be congigured
		walls[0] = true
	else:
		walls[0] = true
		walls[1] = true
	return walls

func _get_neighbors(row : int, column : int) -> Array:
	#This function gets the room indexes of all the neighbors of a particular room
	var neighbors = []
	var left_col : int = column - 1
	var right_col : int = column + 1
	var top_row : int = row - 1
	var bottom_row : int = row + 1
	
	if top_row >= 0:
		neighbors.append((top_row * horizontal_rooms_per_level) + column)
	
	if bottom_row <= vertical_rooms_per_level - 1:
		neighbors.append((bottom_row * horizontal_rooms_per_level) + column)
		
	if left_col >= 0:
		neighbors.append((row * horizontal_rooms_per_level) + left_col)

	if right_col <= horizontal_rooms_per_level - 1:
		neighbors.append((row * horizontal_rooms_per_level) + right_col)
		
	return neighbors

func connect_level(tilemap : TileMap, portal : Area2D, camera : Camera2D) -> void:
	# Connects a particular level. Must be called before calling create_new_level()
	level_tilemap = tilemap 
	level_portal = portal
	level_camera = camera
	
func disconnect_level() -> void:
	# Disconnects a particular level. Must be called after calling create_new_level()
	level_tilemap = null
	level_portal = null
	level_camera = null
