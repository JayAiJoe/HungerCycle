# Customer.gd
# Class representing customers in the ring

extends RingCharacter
class_name Customer

var _CTID : int
var _name : String
var _order : Array            # array of numbers of each element
var _max_order : Array        # array of numbers of each element
var _restrictions : Array     # array of restricted element types
var _gold : int
var _tip : int
var _rep_reward : int
var _effects : Array

# Constructor
func _init(ctid : int = 0) -> void:
	set_customer_data(ctid)

# set this customer's info according to the sid and card database
func set_customer_data(ctid : int) -> void:
	_CTID = ctid
	# TODO: implement initialization. replace code below
	_name = "Customer"
	_order = [2,0,0,0]
	_max_order = [3,0,0,0]
	_restrictions = [1,2,3]
	_gold = 10
	_tip = 2
	_rep_reward = 5
	_effects = []

# Getters
func get_CTID() -> int:
	return _CTID
	
func get_name() -> String:
	return _name

func get_order() -> Array:
	return _order

func get_max_order() -> Array:
	return _max_order

func get_restrictions() -> Array:
	return _restrictions

func get_gold() -> int:
	return _gold

func get_tip() -> int:
	return _tip

func get_rep_reward() -> int:
	return _rep_reward

func get_effects() -> Array:
	return _effects

# TODO: perform customer effects
func perform_effects() -> void:
	pass

	
