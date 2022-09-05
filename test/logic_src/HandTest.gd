# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name HandTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Hand.gd'

var _hand : Hand
var _temp_cards = [Card.new(), Card.new(), Card.new()]

func before() -> void:
	_hand = Hand.new()
	
func test_get_cards() -> void:
	assert_array(_hand.get_cards()).is_empty()

func test_add_card() -> void:
	_hand.add_card(_temp_cards[0])
	_hand.add_card(_temp_cards[1])
	assert_array(_hand.get_cards()).has_size(2)

func test_remove_card() -> void:
	_hand.remove_card(_temp_cards[1])
	_hand.remove_card(_temp_cards[2])
	assert_array(_hand.get_cards()).has_size(1)

func test_get_card_count() -> void:
	_hand.add_card(_temp_cards[2])
	assert_int(_hand.get_card_count()).is_equal(2)

func after() -> void:
	for card in _temp_cards:
		card.free()
	_hand.free()


