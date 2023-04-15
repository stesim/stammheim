extends Area2D


func _physics_process(_delta : float) -> void:
	var bodies := get_overlapping_bodies()
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	if bodies.size() == prisoners.size():
		GameState.escape_area_reached()
		process_mode = Node.PROCESS_MODE_DISABLED
