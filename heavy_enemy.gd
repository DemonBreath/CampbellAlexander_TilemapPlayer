extends CharacterBody2D

@export var explosion_scene: PackedScene

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var dead: bool = false

func _ready() -> void:
	velocity = Vector2.ZERO
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	# Giant enemy is stationary
	velocity = Vector2.ZERO

func take_damage(amount: int) -> void:
	# Prevent double-triggering
	if dead:
		return
	dead = true

	if explosion_scene:
		var explosion := explosion_scene.instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = global_position

		# WAIT for the slow explosion to finish
		await explosion.animation_finished

	# Remove the enemy AFTER explosion finishes
	queue_free()
