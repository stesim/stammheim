extends CharacterBody2D


@export var speed := 128.0
@export var player_controlled := false :
	set(value):
		player_controlled = value
		set_physics_process(player_controlled)
		modulate.a = 1.0 if player_controlled else 0.5


func _ready() -> void:
	player_controlled = player_controlled


func _physics_process(_delta : float) -> void:
	var direction := Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	velocity = speed * direction
	if velocity:
		rotation = velocity.angle()
	move_and_slide()
