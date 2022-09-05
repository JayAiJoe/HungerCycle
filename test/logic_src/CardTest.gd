# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name CardTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Card.gd'

var _card : Card

func before() -> void:
	_card = auto_free(Card.new())

func test_set_card_data() -> void:
	assert_int(_card.get_CID()).is_equal(0)

func test_get_CID() -> void:
	assert_int(_card.get_CID()).is_equal(0)

func test_get_type() -> void:
	assert_int(_card.get_type()).is_equal(0)

func test_get_element() -> void:
	assert_int(_card.get_element()).is_equal(0)

func test_get_name() -> void:
	assert_str(_card.get_name()).is_equal("Empty Card")

func test_get_description() -> void:
	assert_str(_card.get_description()).is_equal("No Description")

func test_get_effects() -> void:
	assert_array(_card.get_effects()).is_empty()

func test_play() -> void:
	# remove this line and complete your test
	assert_not_yet_implemented()

func after() -> void:
	_card.free()
