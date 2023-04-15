extends Node2D


@onready var _game_over_panel := %game_over_panel
@onready var _completion_panel := %completion_panel


func _ready() -> void:
	GameState.game_over.connect(func(): _game_over_panel.show())
	GameState.level_completed.connect(func(): _completion_panel.show())


func _on_restart_button_pressed() -> void:
	GameState.restart()
