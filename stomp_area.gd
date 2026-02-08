extends Area2D

@export var bounce_force: float = -600.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Bounce the player
	if body.has_method("bounce"):
		body.bounce(bounce_force)

	# Find the enemy safely
	var node := get_parent()
	while node != null:
		if node.has_method("take_damage"):
			node.take_damage(1)
			set_deferred("monitoring", false)
			return
		node = node.get_parent()
