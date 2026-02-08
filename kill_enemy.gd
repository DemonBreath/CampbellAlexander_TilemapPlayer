extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity: float = 900.0
@export var patrol_distance: float = 96.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: int = -1
var left_limit: float
var right_limit: float

func _ready() -> void:
	var start_x := global_position.x
	left_limit = start_x - patrol_distance
	right_limit = start_x + patrol_distance
	sprite.play("walk")

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

	# Move
	velocity.x = direction * speed

	# Flip sprite to face movement
	sprite.flip_h = direction > 0

	# Turn around ONCE at limits
	if direction < 0 and global_position.x <= left_limit:
		direction = 1
	elif direction > 0 and global_position.x >= right_limit:
		direction = -1

	move_and_slide()
