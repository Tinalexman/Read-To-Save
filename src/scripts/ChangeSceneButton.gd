tool
extends Button

export(String, FILE) var nextScenePath := ""

func _get_configuration_warning() -> String:
	return "Next Scene Path must be assigned" if nextScenePath == "" else ""
	
func _on_button_up() -> void:
	get_tree().change_scene(nextScenePath)
