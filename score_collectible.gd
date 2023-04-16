extends Area2D


@export var value := 1000


func _on_body_entered(_body : Node2D) -> void:
	GameState.score_collected(value)
	queue_free()
