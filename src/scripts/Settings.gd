extends Control

onready var sfx : CheckButton = $VBoxContainer/HBoxContainer2/SFXButton
onready var music : CheckButton = $VBoxContainer/HBoxContainer/MusicButton

func _ready() -> void:
	sfx.pressed = MusicController.play_sfx
	music.pressed = MusicController.play_music

func _on_music_toggled(button_pressed: bool) -> void:
	if button_pressed:
		MusicController.play()
	else:
		MusicController.stop()

func _on_sfx_toggled(button_pressed: bool) -> void:
	MusicController.play_sfx = button_pressed
