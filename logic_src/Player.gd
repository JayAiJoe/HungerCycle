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

var _turn_draw : int

func _init() -> void:
	# TODO adjust initilaization values
	_starting_deck = Deck.new()
	_draw_pile = Pile.new()
	_discard_pile = Pile.new()
	_hand = Hand.new()
	_staff = []
	_reputation = 0
	_money = 0
	_turn_draw = 3
	
	Events.connect("phase_changed" , self, "handle_phase")
	
	
# Setters
func set_starting_deck(deck : Deck) -> void:
	_starting_deck = deck

func set_starting_deck_with_cids(cids : Array) -> void:
	_starting_deck = Deck.new(cids)

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
	if card in _hand.get_cards():
		card.play()

# draw a card from pile (default: _draw_pile) then add to _hand
func draw_card(pile : Pile = _draw_pile) -> void:
	if pile.get_card_count() > 0:
		var new_card = pile.draw_card()
		_hand.add_card(new_card)
	elif pile == _draw_pile:
		reshuffle_discard_to_draw_pile()
		draw_card()

# discard a card from hand then add to pile (default: _discard_pile)
func discard_card(card: Card, pile : Pile = _discard_pile) -> void:
	if card in _hand.get_cards():
		_hand.remove_card(card)
		pile.add_card(card)

# shuffles discard pile then adds it back to the draw pile
func reshuffle_discard_to_draw_pile() -> void:
	_discard_pile.shuffle()
	while _discard_pile.get_card_count() > 0:
		_draw_pile.add_card(_discard_pile.get_cards().pop_front())

# set the draw pile to the shuffled deck and discard pile to empty
func set_deck_to_piles() -> void:
	_draw_pile.get_cards().clear()
	_discard_pile.get_cards().clear()
	for card in _starting_deck.get_cards():
		_draw_pile.add_card(card)
	_draw_pile.shuffle()

# perform turn phase actions (i.e. draw at turn start, discard hand at turn end)
func handle_phase(phase):
	match(phase):
		Enums.Phases.TURN_START:
			for i in range(_turn_draw):
				draw_card()
		Enums.Phases.TURN_END:
			while _hand.get_card_count() > 0:
				discard_card(_hand.get_cards()[0])
