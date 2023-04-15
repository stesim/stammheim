extends CharacterBody2D


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
