extends CharacterBody2D


@export var speed := 128.0
@export var player_index := -1 :
	set(value):
		player_index = value
		set_physics_process(is_player_controlled())
		_update_color()
		modulate.a = 1.0 if is_player_controlled() else 0.5


@onready var _player_indicator := %player_indicator


func _ready() -> void:
	player_index = player_index


func is_player_controlled() -> bool:
	return player_index >= 0


func _physics_process(_delta : float) -> void:
	if not GameState.is_started():
		return

	var direction := _get_input_direction()
	velocity = speed * direction
	if velocity:
		rotation = velocity.angle()
	move_and_slide()


func _get_input_direction() -> Vector2:
	match player_index:
		0: return Input.get_vector(&"p0.move_left", &"p0.move_right", &"p0.move_up", &"p0.move_down")
		1: return Input.get_vector(&"p1.move_left", &"p1.move_right", &"p1.move_up", &"p1.move_down")
	return Vector2.ZERO


func _update_color() -> void:
	if not _player_indicator:
		return
	var color := Color.WHITE
	match player_index:
		0: color = Color(6.0, 6.0, 0.5)
		1: color = Color(0.5, 6.0, 0.5)
		_:
			_player_indicator.hide()
			return
	_player_indicator.show()
	_player_indicator.modulate = color
