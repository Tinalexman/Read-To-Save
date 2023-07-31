extends Node

onready var player : AudioStreamPlayer = $Music
var play_sfx : bool = true
var play_music : bool = true

func _ready() -> void:
	play()

func play() -> void:
	player.play()

func stop() -> void:
	player.stop()

