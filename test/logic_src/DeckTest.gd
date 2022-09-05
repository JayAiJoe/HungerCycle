# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name DeckTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Deck.gd'

var _deck : Deck

func before() -> void:
	_deck = Deck.new()

func test_get_cards() -> void:
	assert_array(_deck.get_cards()).is_empty()

func test_add_card() -> void:
	_deck.add_card(0)
	_deck.add_card(0)
	assert_array(_deck.get_cards()).has_size(2)

func test_remove_card() -> void:
	_deck.remove_card(0)
	_deck.remove_card(1)
	assert_array(_deck.get_cards()).has_size(1)

func test_get_card_count() -> void:
	_deck.add_card(0)
	_deck.add_card(0)
	assert_int(_deck.get_card_count()).is_equal(3)

func after() -> void:
	for card in _deck.get_cards():
		card.free()
	_deck.free()
