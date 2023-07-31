extends Control

onready var sceneTree := get_tree()
onready var pauseOverlay : ColorRect = get_node("Pause Overlay")
onready var scoreLabel : Label = $Label
onready var pauseLabel : Label = get_node("Pause Overlay/Title")
onready var healthLabel : Label = $Label2
onready var levelLabel : Label = $Label3
onready var revive : Button = get_node('Pause Overlay/Revive')

const death_message : String = "You Died!"

var paused := false setget set_paused

signal revive_player

func _ready() -> void:
	PlayerData.connect("score_update", self, "on_update_interface")
	PlayerData.connect("player_death", self, "on_player_death")
	on_update_interface()

func on_update_interface() -> void:
	scoreLabel.text = "Coins: %s" % PlayerData.score
	healthLabel.text = "Life: %s" % PlayerData.life
	levelLabel.text = "Level: %s" % PlayerData.current_level
	revive.text = "Revive for %s coins?" % PlayerData.revive_coin


func on_player_death() -> void:
	if PlayerData.life == 0:
		self.paused = true
		pauseLabel.text = death_message
	healthLabel.text = "Life: %s" % PlayerData.life

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pauseLabel.text != death_message:
		self.paused = not paused
		sceneTree.set_input_as_handled()

func set_paused(value : bool) -> void:
	paused = value
	sceneTree.paused = value
	pauseOverlay.visible = value


func _on_revive_button_up() -> void:
	if PlayerData.score >= PlayerData.revive_coin:
		PlayerData.score -= PlayerData.revive_coin
		PlayerData.life = 3
		self.paused = not self.paused
		emit_signal("revive_player")
