extends Command
class_name DiscardCommand

# error when type-hinting card: https://www.reddit.com/r/godot/comments/hu213d/class_was_found_in_global_scope_but_its_script/

var _target

func _init(card) -> void:
	_actor_code = Enums.Actors.PLAYER
	_target = card

func execute():
	_actor.discard_card(_target)
	emit_signal("executed")
