extends Command
class_name DrawCommand

func _init() -> void:
	_actor_code = Enums.Actors.PLAYER
	
func execute():
	_actor.draw_card()
	emit_signal("executed")
