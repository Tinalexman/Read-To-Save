extends Node

signal score_update
signal player_death

var score : int = 0 setget set_score
var deaths : int = 0 setget set_deaths
var life : int = 3
var current_level : int = 1

const revive_coin : int = 5

func set_score(value : int) -> void:
	score = value
	emit_signal("score_update")

func set_deaths(value : int) -> void:
	deaths = value
	life -= 1
	emit_signal("player_death")

func refresh() -> void:
	life = 3
	current_level += 1

func reset():
	score = 0
	deaths = 0
	life = 3
