# Command.gd
# Base class for all commands for card and character effects

extends Object
class_name Command

# emit after each execution
signal executed

var _actor : Object
var _actor_code : int

func _init() -> void:
	_actor_code = Enums.Actors.NONE

func set_actor(entity : Object) -> void:
	_actor = entity

func get_actor_code() -> int:
	return _actor_code

func execute():
	emit_signal("executed")

