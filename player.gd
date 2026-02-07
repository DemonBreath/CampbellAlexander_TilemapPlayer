extends CharacterBody2D

@export var speed := 200
@export var run_speed := 320
@export var jump_velocity := -350
@export var gravity := 900

@onready var sprite := $AnimatedSprite2D

func _ready():
	sprite.play("idle")

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Input
	var direction := Input.get_axis("ui_left", "ui_right")

	# Jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity

	# Horizontal movement
	if direction != 0:
		var current_speed := speed
		if Input.is_action_pressed("ui_shift"):
			current_speed = run_speed

		velocity.x = direction * current_speed
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	position = position.round()

	update_animation(direction)

func update_animation(direction):
	if not is_on_floor():
		if velocity.y < 0:
			play_if_not("jump")
		else:
			play_if_not("fall")
	else:
		if direction == 0:
			play_if_not("idle")
		else:
			if Input.is_action_pressed("ui_shift"):
				play_if_not("run")
			else:
				play_if_not("walk")

func play_if_not(name: String):
	if sprite.animation != name:
		sprite.play(name)
