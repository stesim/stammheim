extends CharacterBody2D


const DEFAULT_SPEED := 64.0


@export var speed := 64.0 :
	set(value):
		if value == speed:
			return
		speed = value
		if _animation_player:
			_animation_player.speed_scale = speed / DEFAULT_SPEED


@onready var _light : PointLight2D = %light
@onready var _animation_player : AnimationPlayer = %animation_player


func _ready() -> void:
	_light.energy += randf_range(-0.75, 0.25)


func _on_view_area_body_entered(body : Node2D) -> void:
	if _is_view_to_target_unobstructed(body):
		GameState.prisoner_detected()


func _is_view_to_target_unobstructed(target : Node2D) -> bool:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(
		global_position,
		target.global_position,
		1,
	)
	var result := space_state.intersect_ray(query)
	return result.is_empty()
