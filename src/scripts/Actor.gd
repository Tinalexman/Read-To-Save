extends KinematicBody2D
class_name Actor

export var speed := Vector2(300.0, 1000.0)
export var gravity := 3000.0

var upVector = Vector2.UP
var _velocity := Vector2.ZERO
var _max_velocity := 500.0


func _physics_process(_delta: float) -> void:
	return
