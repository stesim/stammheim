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


func _unhandled_input(event : InputEvent) -> void:
	if not player_controlled:
		return
	if event.is_action_pressed(&"switch_character"):
		_switch_character()


func _switch_character() -> void:
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	var current_character_index := prisoners.find(self)
	var next_character := prisoners[(current_character_index + 1) % prisoners.size()]

	self.player_controlled = false
	next_character.player_controlled = true
