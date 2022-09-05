# Card.gd
# Class for in-game cards

extends Object
class_name Card

var _CID : int
var _type : int
var _element : int
var _name : String
var _description : String
var _effects : Array

# Constructor
func _init(cid : int = 0) -> void:
	set_card_data(cid)

# set this card's info according to the cid and  card database
func set_card_data(cid : int) -> void:
	_CID = cid
	# TODO: implement card initialization. replace code below
	_type = 0
	_element = 0
	_name = "Empty Card"
	_description = "No Description"
	_effects = []

# Getters
func get_CID() -> int:
	return _CID

func get_type() -> int:
	return _type

func get_element() -> int:
	return _element

func get_name() -> String:
	return _name

func get_description() -> String:
	return _description

func get_effects() -> Array:
	return _effects

# perform the card's play effects
func play() -> void:
	# TODO: implement card play method
	pass
