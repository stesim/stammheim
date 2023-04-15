extends Node


signal game_over()
signal level_completed()


@onready var _tree := get_tree()


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
	if event.is_action_pressed(&"switch_character"):
		_switch_character()


func _switch_character() -> void:
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	var current_character_index := 0
	for prisoner in prisoners:
		if prisoner.player_controlled:
			break
		current_character_index += 1

	var next_character := prisoners[(current_character_index + 1) % prisoners.size()]

	prisoners[current_character_index].player_controlled = false
	next_character.player_controlled = true
