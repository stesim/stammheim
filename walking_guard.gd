extends Path2D


@export var speed := 32.0
@export var go_back := false

@onready var _follow : PathFollow2D = %follow
@onready var _guard : CharacterBody2D = %follow/guard

var rng = RandomNumberGenerator.new()
var direction := 1.0
var sleeping := 0.0
var  rnd_speed := 1.0

func _ready():
	_follow.loop = !go_back
	rnd_speed = rng.randf_range(0.5, 2.0)

func _physics_process(delta : float) -> void:
	sleeping -= delta
	if sleeping <= -5.0:
		sleeping = rng.randf_range(-5.0, 5.0)
	if sleeping > 0.0:
		return
	
	_follow.progress += direction * delta * speed * rnd_speed
	if _follow.progress_ratio >= 1.0 and go_back:
		direction *= -1.0
		_guard.rotation += PI
	elif _follow.progress_ratio <= 0.0 and go_back:
		direction *= -1.0
		_guard.rotation -= PI
			
