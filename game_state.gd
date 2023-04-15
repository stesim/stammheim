extends Node


signal game_over()
signal level_completed()


var _started := false


@onready var _tree := get_tree()


func start() -> void:
	_started = true


func is_started() -> bool:
	return _started


func restart() -> void:
	_tree.reload_current_scene()
	_tree.paused = false


func prisoner_detected() -> void:
	_tree.paused = true
	print("game over")
	game_over.emit()


func escape_area_reached() -> void:
	_tree.paused = true
	print("level completed")
	level_completed.emit()


func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed(&"p0.switch_character"):
		_switch_character(0)
	if event.is_action_pressed(&"p1.switch_character"):
		_switch_character(1)


func _switch_character(player_index : int) -> void:
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	var current_character_index := 0
	for prisoner in prisoners:
		if prisoner.player_index == player_index:
			break
		current_character_index += 1

	if current_character_index < prisoners.size():
		prisoners[current_character_index].player_index = -1

	for i in prisoners.size():
		var index := (current_character_index + i + 1) % prisoners.size()
		var prisoner := prisoners[index]
		if not prisoner.is_player_controlled():
			prisoner.player_index = player_index
			break
