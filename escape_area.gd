extends Area2D


func _physics_process(_delta : float) -> void:
	if not has_overlapping_bodies():
		return
	var num_prisoners_in_area := get_overlapping_bodies().size()
	var num_prisoners := GameState.get_prisoners().size()
	if num_prisoners_in_area == num_prisoners:
		GameState.escape_area_reached()
		process_mode = Node.PROCESS_MODE_DISABLED
