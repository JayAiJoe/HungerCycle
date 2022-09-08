extends Node2D

onready var card = $CardAvatar

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		card.go_to_pile(get_global_mouse_position())
