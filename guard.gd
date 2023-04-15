extends CharacterBody2D


func _on_view_area_body_entered(_body : Node2D) -> void:
	GameState.prisoner_detected()
