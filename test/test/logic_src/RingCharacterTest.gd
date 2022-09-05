# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name RingCharacterTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://test/logic_src/RingCharacter.gd'

var _rc_left : RingCharacter
var _rc_mid : RingCharacter
var _rc_right : RingCharacter

func before() -> void:
	_rc_left = RingCharacter.new()
	_rc_mid = RingCharacter.new()
	_rc_right = RingCharacter.new()
	
func test_set_get_left() -> void:
	_rc_mid.set_left(_rc_left)
	assert_object(_rc_mid.get_left()).is_same(_rc_left)

func test_set_get_right() -> void:
	_rc_mid.set_right(_rc_right)
	assert_object(_rc_mid.get_right()).is_same(_rc_right)

func test_is_movable() -> void:
	assert_bool(_rc_mid.is_movable()).is_true()

func after() -> void:
	_rc_left.free()
	_rc_mid.free()
	_rc_right.free()



