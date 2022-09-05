# Deck.gd
# Class for starting deck
# Only a container of cards

extends Object
class_name Deck

var _cards : Array

func _init() -> void:
	_cards = []

# return all cards in this deck
func get_cards() -> Array:
	return _cards

# add a new card to deck by cid
func add_card(cid : int) -> void:
	_cards.append(Card.new())

# remove the first card in the deck with the given cid
func remove_card(cid : int) -> void:
	for card in _cards:
		if card.get_CID() == cid:
			_cards.erase(card)
			return

# return card count
func get_card_count() -> int:
	return _cards.size()
