extends Node

var coin : PackedScene = preload("res://src/objects/Coin.tscn")
var enemy : PackedScene = preload("res://src/actors/Enemy.tscn")
var portal : PackedScene = preload("res://src/objects/Portal.tscn")

var tile_id : Array = [0] # The tilesets present in the tilemap
var level_tilemap : TileMap = null # The tilemap of the level being generated
var level_camera : Camera2D = null # The camera of the player
var level_coins : Node2D = null # The coins in the level
var level_enemies : Node2D = null # The enemies in the level
var level_player : KinematicBody2D = null # The player in the level
var level_portal : Area2D = null # The portal of a level

var block_size : int = 80 # The size of a block in pixels

var room_width_per_block : int = 22 # The number of blocks needed to make up a room's width
var room_height_per_block : int = 14 # The number of blocks needed to make up a room's height

var horizontal_rooms_per_level : int = 4 # The number of rooms to make up a level's width
var vertical_rooms_per_level : int = 3 # The number of rooms to make up a level's height

const multiplier : int = 359 # The row multiplier

const bottom_exit_size : int = 4 # The size, in blocks, of a bottom exit
const side_exit_size : int = 3 # The size, in blocks, of a bottom exit
const side_exit_stump : int = 2 # The height, in blocks, of a side exit from the bottom wall

const level_path : String = "res://src/levels/Level.tscn" # The path to the level scene file

const tile_eraser : int = -1 # It erases a block tile

var assigned_rooms : Array = []
var down_path_rooms : Array = []

var portal_position : int = 0
var total_rooms : int = 0

func connect_level(tilemap : TileMap, enemies : Node2D, coins : Node2D, player : KinematicBody2D, camera : Camera2D) -> void:
	level_tilemap = tilemap
	level_enemies = enemies
	level_coins = coins
	level_player = player
	level_camera = camera

func disconnect_level() -> void:
	level_tilemap = null
	level_camera = null
	level_coins = null 
	level_enemies = null
	level_player = null
	level_portal = null

func get_portal() -> Area2D:
	return level_portal

func create_new_level() -> void:
	
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
	
	# Choose the direction for the portal
	portal_position = rand_range(0, 1)
	
	# Set the camera limits
	level_camera.limit_right = level_width * block_size
	level_camera.limit_bottom = level_height * block_size

	_create_room(0)

func _create_room(room_index : int) -> void:
	# If the rooms has already been assigned, skip it
	if assigned_rooms[room_index] == true:
		return
	
	# Get the row and column position of the room in the level
# warning-ignore:integer_division
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
	_draw_random_room_contents(row, column)

func _draw_random_room_contents(row : int, column : int) -> void:
	# Get a random room
	var index : int = rand_range(0, RoomData.size())
	if index >= RoomData.size():
		index = 0
	
	# Get the offset in the number of tiles from [0, 0]
	var row_offset : int = row * (room_height_per_block + 1)
	var column_offset : int = column * (room_width_per_block + 1)
	
	# Get the offset in terms of pixels
	var y_offset : int = row_offset * block_size
	var x_offset : int = column_offset * block_size
	
	# If it is the correct room to place the portal
	var room_index : int = (row * horizontal_rooms_per_level) + column
	if room_index == total_rooms - 1:
		level_portal = portal.instance()
		level_portal.nextScenePath = level_path
		level_portal.position.x = x_offset + RoomData.right_portal_position[0]
		level_portal.position.y = y_offset + RoomData.right_portal_position[1]
	
	# Draw the obstacles in the room
	var coordinates : Array = RoomData.room_data[index]
	for coordinate in coordinates:
		level_tilemap.set_cell(column_offset + coordinate[0], row_offset + coordinate[1], tile_id[0])
	
	# Place the enemies
	var enemies : Array = RoomData.enemy_data[index]
	for coordinate in enemies:
		var new_enemy : Node = enemy.instance()
		new_enemy.position.x = x_offset + coordinate[0]
		new_enemy.position.y = y_offset + coordinate[1]
		level_enemies.add_child(new_enemy)

	# Place the coins
	var coins : Array = RoomData.coin_data[index]
	for coordinate in coins:
		var new_coin : Node = coin.instance()
		new_coin.position.x =  x_offset + coordinate[0]
		new_coin.position.y = y_offset + coordinate[1]
		level_coins.add_child(new_coin)

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
