extends CanvasLayer

@onready var health_icon: TextureRect = $HealthIcon

func show_health_icon() -> void:
	health_icon.visible = true
