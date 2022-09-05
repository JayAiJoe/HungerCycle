# RingCharacter.gd
# Base class for any entity in the ring 

extends Object
class_name RingCharacter

var _left : RingCharacter
var _right : RingCharacter
var _movable : bool

func _init() -> void:
	_movable = true

# Setters
func set_left(rc : RingCharacter) -> void:
	_left = rc

func set_right(rc : RingCharacter) -> void:
	_right = rc

# Getters
func get_left() -> RingCharacter:
	return _left

func get_right() -> RingCharacter:
	return _right

func is_movable() -> bool:
	return _movable
