extends Area2D

@export var heal_amount: int = 25

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("heal"):
		body.heal(heal_amount)

		var ui := get_tree().get_first_node_in_group("ui")
		if ui != null:
			ui.show_health_icon()

		queue_free()
