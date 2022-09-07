# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name RingTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://test/logic_src/Ring.gd'

var _ring : Ring
var _left = RingCharacter.new()
var _right = RingCharacter.new()

func before() -> void:
	_ring = Ring.new()
	
func test_get_characters() -> void:
	assert_array(_ring.get_characters()).has_size(1)
	assert_object(_ring.get_characters()[0]).is_instanceof(RingDoor)

func test_get_character_count() -> void:
	assert_int(_ring.get_character_count()).is_equal(1)

func test_get_door() -> void:
	assert_object(_ring.get_door()).is_instanceof(RingDoor)

func test_get_current_character() -> void:
	assert_object(_ring.get_current_character()).is_same(_ring.get_door())

func test_insert_character_left() -> void:
	_ring.insert_character_left(_left)
	assert_object(_ring.get_door().get_left()).is_same(_left)

func test_insert_character_right() -> void:
	_ring.insert_character_right(_right)
	assert_object(_ring.get_door().get_right()).is_same(_right)

func test_get_characters_in_order() -> void:
	assert_int(_ring.get_character_count()).is_equal(3)
	assert_array(_ring.get_characters_in_order()).contains_exactly([_ring.get_door(), _right, _left])

func test_move_character_left() -> void:
	_ring.move_character_left(_left)
	assert_array(_ring.get_characters_in_order()).contains_exactly([_ring.get_door(), _left, _right])

func test_move_character_right() -> void:
	_ring.move_character_right(_left)
	assert_array(_ring.get_characters_in_order()).contains_exactly([_ring.get_door(), _right, _left])

func test_remove_character() -> void:
	_ring.remove_character(_left)
	assert_array(_ring.get_characters_in_order()).contains_exactly([_ring.get_door(), _right])

func after() -> void:
	_ring.free()
	_left.free()
	_right.free()
	


