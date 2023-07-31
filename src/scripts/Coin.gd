extends Area2D

export var score := 1

onready var player : AnimationPlayer = $AnimationPlayer
onready var sfx : AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(_body: Node) -> void:
	picked()

func picked() -> void:
	PlayerData.score += self.score
	if MusicController.play_sfx:
		sfx.play()
	player.play("Fade Out")
	yield(player, "animation_finished")
	queue_free()
