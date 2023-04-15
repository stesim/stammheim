extends Path2D


@export var speed := 32.0


@onready var _follow : PathFollow2D = %follow


func _physics_process(delta : float) -> void:
	_follow.progress += delta * speed
