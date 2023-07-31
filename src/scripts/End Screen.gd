extends Control

onready var scoreLabel : Label = $Label

func _ready() -> void:
	scoreLabel.text = scoreLabel.text % [PlayerData.score, PlayerData.deaths] 
