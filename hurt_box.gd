extends Area2D

func _ready() -> void:
	print("HurtBox READY | monitoring =", monitoring)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	print("HURTBOX HIT:", body.name)
	if body.has_method("die"):
		body.die()
