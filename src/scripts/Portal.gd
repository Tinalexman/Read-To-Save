tool
extends Area2D

export(String, FILE) var nextScenePath : String = ""

onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _get_configuration_warning() -> String:
	return "The next scene property is not defined" if nextScenePath == "" else ""
	
func _on_body_entered(_body: Node) -> void:
	teleport()

func teleport() -> void:
	animationPlayer.play("Fade In")
	yield(animationPlayer, "animation_finished")
	#PlayerData.current_level += 1
	PlayerData.refresh()
	get_tree().change_scene(nextScenePath)
