extends Node2D


@onready var _game_over_panel := %game_over_panel
@onready var _completion_panel := %completion_panel
@onready var _score_label := %score_label
@onready var _character_selection_panel := %character_selection_panel
@onready var _crew_selection_slider := %crew_selection_slider
@onready var _alarm_track := %alarm_track
@onready var _timer_label := %timer_label


func _ready() -> void:
	GameState.game_over.connect(
		func():
			_game_over_panel.show()
			_alarm_track.play()
	)
	GameState.level_completed.connect(
		func():
			_completion_panel.show()
			_score_label.text = str(GameState.get_score())
	)
	_on_crew_selection_slider_value_changed(_crew_selection_slider.value)


func _process(_delta : float) -> void:
	if GameState.is_started():
		var time := GameState.get_time_since_start()
		var seconds := time % 60
		@warning_ignore("integer_division")
		var minutes := time / 60
		_timer_label.text = "%d:%02d" % [minutes, seconds]


func _on_restart_button_pressed() -> void:
	GameState.restart()


func _on_start_button_pressed() -> void:
	var num_characters := int(_crew_selection_slider.value)
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	for i in prisoners.size():
		if i >= num_characters:
			prisoners[i].queue_free()
	_character_selection_panel.hide()
	GameState.start()


func _on_crew_selection_slider_value_changed(value : float) -> void:
	var num_characters := int(value)
	var prisoners := get_tree().get_nodes_in_group(&"prisoners")
	for i in prisoners.size():
		prisoners[i].visible = i < num_characters
