extends Light2D

var _timer = rand_range(0, 999)
var original_position : Vector2 = Vector2.ZERO
var h_limit : int = 500
var v_limit : int = 300
var inc : int = 2
export var moving_right : bool = true
export var moving_up : bool = true

func _ready() -> void:
	original_position = position

func _process(_delta: float) -> void:
	_timer += 1
	var new_scale = sin(_timer * 0.1) * 0.02
	scale = Vector2(1 - new_scale, 1 - new_scale)
	if moving_right:
		if position.x > original_position.x + h_limit:
			moving_right = false
		position.x += inc
	else:
		if position.x < original_position.x - h_limit:
			moving_right = true
		position.x -= inc
		
	if moving_up:
		if position.y > original_position.y + v_limit:
			moving_up = false
		position.y += inc
	else:
		if position.y < original_position.y - v_limit:
			moving_up = true
		position.y -= inc
