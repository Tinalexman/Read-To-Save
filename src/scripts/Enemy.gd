extends Actor


var timer_delay := 5.0
var current_time := 0.0
var increment := 10

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	current_time += delta
	if current_time >= timer_delay:
		if _velocity.x < 0:
			_velocity.x -= increment
		elif _velocity.x > 0:
			_velocity.x += increment
		current_time = 0.0
	
	_velocity.x = min(_velocity.x, _max_velocity)
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, upVector).y
