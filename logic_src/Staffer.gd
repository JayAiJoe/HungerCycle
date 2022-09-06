# Staffer.gd
# Class representing staff members in the ring

extends RingCharacter
class_name Staffer

var _SID : int
var _name : String
var _skill_name : String
var _skill_cost : int
var _skill_element : int
var _skill_effects : Array

# Constructor
func _init(sid : int = 0) -> void:
	set_staffer_data(sid)

# set this card's info according to the sid and card database
func set_staffer_data(sid : int) -> void:
	_SID = sid
	# TODO: implement card initialization. replace code below
	_name = "Staffer"
	_skill_name = "Staffer Skill"
	_skill_cost = 5
	_skill_element = 1
	_skill_effects = []


# Getters
func get_SID() -> int:
	return _SID

func get_name() -> String:
	return _name

func get_skill_name() -> String:
	return _skill_name

func get_skill_cost() -> int:
	return _skill_cost

func get_skill_element() -> int:
	return _skill_element

func get_skill_effects() -> Array:
	return _skill_effects

# TODO: Perform skill effects
func activate_skill() -> void:
	pass
