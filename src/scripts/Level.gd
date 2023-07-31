extends Node2D

onready var tilemap : TileMap = $TileMap
onready var enemies : Node2D = $Enemies
onready var coins : Node2D = $Coins
onready var player : KinematicBody2D = $Player
onready var camera : Camera2D = $Player/Camera2D

onready var animation : AnimationPlayer = $AnimationPlayer

export var save_tilemap : bool = false

func _ready() -> void:
	if save_tilemap:
		_save_tile_map()

	LevelGenerator.connect_level(tilemap, enemies, coins, player, camera)
	LevelGenerator.create_new_level()
	add_child(LevelGenerator.get_portal())
	LevelGenerator.disconnect_level()

func clear_level() -> void:
	for node in enemies.get_children():
		node.queue_free()
	
	for node in coins.get_children():
		node.queue_free()
	
	for i in range (1 + (LevelGenerator.horizontal_rooms_per_level * (LevelGenerator.room_width_per_block + 1))):
		for j in range(1 + (LevelGenerator.vertical_rooms_per_level * (LevelGenerator.room_height_per_block + 1))):
			tilemap.set_cell(i, j, LevelGenerator.tile_eraser)

func _save_tile_map() -> void:
	var tiles : Array = []
	for i in range (1, LevelGenerator.room_width_per_block + 1):
		for j in range(1, LevelGenerator.room_height_per_block + 1):
			if tilemap.get_cell(i, j) != -1:
				tiles.append([i, j])
	
	var enemies_list : Array = []
	for enemy in enemies.get_children():
		enemies_list.append(enemy.position)
	

	var coins_list : Array = []
	for coin in coins.get_children():
		coins_list.append(coin.position)
		
	print("Tiles")
	print(tiles)
	
	print()
	
	print("Enemy Positions")
	print(enemies_list)
	
	print()
	
	print("Coin Positions")
	print(coins_list)
