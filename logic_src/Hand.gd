# Hand.gd
# Class representing in-game hand of cards

extends Object
class_name Hand

var _cards : Array

func _init() -> void:
	_cards = []

# return all cards in hand
func get_cards() -> Array:
	return _cards

# add a card to hand by reference
func add_card(card : Card) -> void:
	_cards.append(card)

# remove a card from hand by reference
func remove_card(card : Card) -> void:
	if card in _cards:
		_cards.erase(card)
