extends CharacterBody2D

@export var speed: int = 200
@export var run_speed: int = 320
@export var jump_velocity: float = -350.0
@export var gravity: float = 900.0

@export var max_health: int = 100
var health: int = 100

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var spawn_position: Vector2

func _ready() -> void:
	sprite.play("idle")
	spawn_position = global_position
	health = max_health

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Input
	var direction: float = Input.get_axis("ui_left", "ui_right")

	# Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity

	# Horizontal movement
	if direction != 0.0:
		var current_speed: int = speed
		if Input.is_action_pressed("ui_shift"):
			current_speed = run_speed

		velocity.x = direction * current_speed
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)

	move_and_slide()

	# Pixel-perfect movement
	position = position.round()

	update_animation(direction)

func update_animation(direction: float) -> void:
	if not is_on_floor():
		if velocity.y < 0.0:
			play_if_not("jump")
		else:
			play_if_not("fall")
	else:
		if direction == 0.0:
			play_if_not("idle")
		else:
			if Input.is_action_pressed("ui_shift"):
				play_if_not("run")
			else:
				play_if_not("walk")

func play_if_not(name: String) -> void:
	if sprite.animation != name:
		sprite.play(name)

# -------------------------
# ASSIGNMENT FUNCTIONS
# -------------------------

func heal(amount: int) -> void:
	health = min(health + amount, max_health)

func bounce(force: float) -> void:
	velocity.y = force

func die() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	health = max_health
