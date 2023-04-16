extends Node


signal game_over()
signal level_completed()


var _started := false
var _start_time := 0
var _end_time := 0


@onready var _tree := get_tree()


func start() -> void:
	_started = true
	_start_time = Time.get_ticks_msec()


func is_started() -> bool:
	return _started


func restart() -> void:
	_tree.reload_current_scene()
	_tree.paused = false


func prisoner_detected() -> void:
	_stop_game()
	game_over.emit()


func escape_area_reached() -> void:
	_end_time = Time.get_ticks_msec()
	_stop_game()
	level_completed.emit()


func get_time_since_start() -> int:
	@warning_ignore("integer_division")
	return (Time.get_ticks_msec() - _start_time) / 1000 if _started else 0


func get_score() -> int:
	var elapsed_time := (_end_time - _start_time) / 1000.0;
	var num_prisoners := get_tree().get_nodes_in_group(&"prisoners").size()
	return int(num_prisoners / elapsed_time * 100000)


func _stop_game() -> void:
	_started = false
	_tree.paused = true


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
