extends Control

onready var sceneTree := get_tree()
onready var pauseOverlay : ColorRect = get_node("Pause Overlay")
onready var scoreLabel : Label = $Label
onready var pauseLabel : Label = get_node("Pause Overlay/Title")
onready var healthLabel : Label = $Label2
onready var levelLabel : Label = $Label3
onready var reviveLabel : Label = $Label4

var paused := false setget set_paused

func _ready() -> void:
	PlayerData.connect("player_death", self, "on_player_death")
	on_update_interface()

func on_update_interface() -> void:
	scoreLabel.text = "Coins: %s" % PlayerData.score
	healthLabel.text = "Life: %s" % PlayerData.life
	levelLabel.text = "Level: %s" % PlayerData.current_level
	reviveLabel.text = "Revive for %s coins" % PlayerData.revive_coins

func _on_player_death() -> void:
	if PlayerData.life == 0:
		self.paused = true
	healthLabel.text = "Life: %s" % PlayerData.life

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		sceneTree.set_input_as_handled()

func set_paused(value : bool) -> void:
	paused = value
	sceneTree.paused = value
	pauseOverlay.visible = value
