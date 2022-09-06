# Player.gd
# Class representing the chef player

extends Object
class_name Player

var _starting_deck : Deck
var _draw_pile : Pile
var _discard_pile : Pile
var _hand : Hand
var _staff : Array
var _reputation : int
var _money : int

var _flow : int
var _flow_element : int

func _init() -> void:
	pass

# Setters
func set_starting_deck(deck : Deck) -> void:
	_starting_deck = deck

func set_draw_pile(pile : Pile) -> void:
	_draw_pile = pile

func set_discard_pile(pile : Pile) -> void:
	_discard_pile = pile

func set_hand(hand : Hand) -> void:
	_hand = hand

func set_reputation(rep : int) -> void:
	_reputation = rep

func set_money(money : int) -> void:
	_money = money


# Getters
func get_starting_deck() -> Deck:
	return _starting_deck

func get_draw_pile() -> Pile:
	return _draw_pile

func get_discard_pile() -> Pile:
	return _discard_pile

func get_hand() -> Hand:
	return _hand

func get_staff() -> Array:
	return _staff

func get_reputation() -> int:
	return _reputation

func get_money() -> int:
	return _money


# add staff based on a sid
func add_staff(sid : int) -> void:
	_staff.append(Staffer.new(sid))

# remove staff based on sid
func remove_staff(sid : int) -> void:
	for i in len(_staff):
		if _staff[i].get_SID() == sid:
			_staff.pop_at(i)
			return

# play a card
func play_card(card : Card) -> void:
	card.play()

# draw a card from pile (default: _draw_pile) then add to _hand
func draw_card(pile : Pile = _draw_pile) -> void:
	var new_card = pile.draw_card()
	_hand.add_card(new_card)

# discard a card from hand then add to pile (default: _discard_pile)
func discard_card(card: Card, pile : Pile = _discard_pile) -> void:
	_hand.remove_card(card)
	pile.add_card(card)

# shuffles discard pile then adds it back to the draw pile
func reshuffle_discard_to_draw_pile() -> void:
	_discard_pile.shuffle()
	for card in _discard_pile:
		_draw_pile.add_card(card)
	
