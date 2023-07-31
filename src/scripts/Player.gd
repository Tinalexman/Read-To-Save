extends Actor

export var stomp_impulse := 1000
export var player_position : Vector2 = Vector2.ZERO

onready var sprite : Sprite = $player
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	connect("revive_player", self, "_revive")

func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	_velocity = calculateStompVelocity(_velocity, stomp_impulse)
	
func _on_EnemyDetector_body_entered(_body: Node) -> void:
	PlayerData.deaths += 1
	if MusicController.play_sfx:
		audio_player.play()
	change_color()

func _physics_process(_delta: float) -> void:
	var interruptedJump := Input.is_action_just_released("jump") and _velocity.y < 0
	var direction = calculateDirection()
	_velocity = calculateMoveVelocity(_velocity, speed, direction, interruptedJump)
	_velocity = move_and_slide(_velocity, upVector)
	return
	
func calculateDirection() -> Vector2:
	return Vector2(
		Input.get_action_strength("move right") - Input.get_action_strength("move left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculateMoveVelocity(linear_velocity: Vector2, speed: Vector2, direction: Vector2, interruptedJump: bool) -> Vector2:
	var newVelocity = linear_velocity
	newVelocity.x = speed.x * direction.x;
	newVelocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		newVelocity.y = speed.y * direction.y
	if interruptedJump:
		newVelocity.y = 0
	return newVelocity

func calculateStompVelocity(velocity: Vector2, impulse: float) -> Vector2:
	var out := velocity
	out.y = -impulse
	return out

func die() -> void:
	queue_free()

func _revive() -> void:
	reset()
	PlayerData.life = 3

func reset() -> void:
	sprite.modulate.r = 1.0
	sprite.modulate.g = 1.0
	sprite.modulate.b = 0.0

func change_color() -> void:
	if PlayerData.life == 2:
		sprite.modulate.b = 1.0
	elif PlayerData.life == 1:
		sprite.modulate.g = 0.0
		sprite.modulate.b = 0.0
	return
