# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name PileTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Pile.gd'

var _pile : Pile
var _temp_cards : Array

func before() -> void:
	_pile = Pile.new()
	_temp_cards = [Card.new(0), Card.new(1), Card.new(2)]
	
func test_get_cards() -> void:
	assert_array(_pile.get_cards()).is_empty()

func test_add_card() -> void:
	_pile.add_card(_temp_cards[0])
	_pile.add_card(_temp_cards[1])
	assert_array(_pile.get_cards()).has_size(2)

func test_get_card_count() -> void:
	assert_int(_pile.get_card_count()).is_equal(2)

func test_insert_card() -> void:
	_pile.insert_card(_temp_cards[2], 1)
	assert_object(_pile.get_cards()[1]).is_same(_temp_cards[2])

func test_remove_card() -> void:
	_pile.remove_card(_temp_cards[2])
	assert_bool(_temp_cards[2] in _pile.get_cards()).is_false()

func test_remove_card_by_index() -> void:
	_pile.remove_card_by_index(1)
	assert_bool(_temp_cards[1] in _pile.get_cards()).is_false()

func test_draw_card() -> void:
	_pile.add_card(_temp_cards[1])
	_pile.add_card(_temp_cards[2])
	var temp = _pile.draw_card()
	assert_object(temp).is_same(_temp_cards[0])
	assert_bool(_temp_cards[0] in _pile.get_cards()).is_false()

func test_peek_card() -> void:
	var temp = _pile.peek_card()
	assert_object(temp).is_same(_temp_cards[1])
	assert_bool(_temp_cards[1] in _pile.get_cards()).is_true()

func test_draw_card_with_conditions() -> void:
	var temp = _pile.draw_card_with_conditions({"cid" : 2})
	assert_object(temp).is_same(_temp_cards[2])
	assert_bool(_temp_cards[2] in _pile.get_cards()).is_false()

func after() -> void:
	for card in _temp_cards:
		card.free()
	_pile.free()
