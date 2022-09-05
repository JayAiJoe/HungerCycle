# Pile.gd
# Class representing in-game pile of cards
# i.e. draw and discard piles
extends Object
class_name Pile

var _cards : Array

func _init() -> void:
	_cards = []

# return all cards in pile
func get_cards() -> Array:
	return _cards

# return card count
func get_card_count() -> int:
	return _cards.size()

# add card to bottom of pile by reference
func add_card(card : Card) -> void:
	_cards.append(card)

# insert card to specific index
# index 0 : top, -1 : bottom
func insert_card(card : Card, index : int) -> void:
	_cards.insert(index, card)

# remove a card from pile by reference
func remove_card(card : Card) -> void:
	if card in _cards:
		_cards.erase(card)

# remove a card from pile by index
# index 0 : top, -1 : bottom
func remove_card_by_index(index : int) -> void:
	_cards.remove(index)

# pop and return card at specified index
# index 0 : top (default), -1 : bottom
func draw_card(index : int = 0) -> Card:
	return _cards.pop_at(index)

# return reference to card at specified index without popping
# index 0 : top (default), -1 : bottom
func peek_card(index : int = 0) -> Card:
	return _cards[index]

# pop and return the first card the matches the given conditions
func draw_card_with_conditions(conditions : Dictionary) -> Card:
	var index = -1
	for card in _cards:
		index += 1
		if "cid" in conditions and card.get_CID() != conditions.cid:
			continue
		if "type" in conditions and card.get_type() != conditions.type:
			continue
		if "element" in conditions and card.get_element != conditions.element:
			continue
		return _cards.pop_at(index)
	return null

# randomly rearrange cards
func shuffle() -> void:
	randomize()
	_cards.shuffle()
