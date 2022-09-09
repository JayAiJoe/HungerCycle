extends Area2D
class_name CardPlayArea

signal targeted(play_target, state)

export var play_target : int = Enums.CardTargets.GENERAL

func set_target(target : int) -> void:
	play_target = target

func _on_PlayArea_mouse_entered() -> void:
	emit_signal("targeted", play_target, true)


func _on_PlayArea_mouse_exited() -> void:
	emit_signal("targeted", play_target, false)
