extends Path2D


@export var speed := 32.0
@export var go_back := false

@onready var _follow : PathFollow2D = %follow
@onready var _guard : CharacterBody2D = %follow/guard

var direction := 1.0

func _ready():
	_follow.loop = !go_back


func _physics_process(delta : float) -> void:
	_follow.progress += direction * delta * speed
	if _follow.progress_ratio >= 1.0 and go_back:
		direction *= -1.0
		_guard.rotation += PI
	if _follow.progress_ratio <= 0.0 and go_back:
		direction *= -1.0
		_guard.rotation -= PI
			
