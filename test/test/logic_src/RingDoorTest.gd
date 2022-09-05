# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name RingDoorTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://test/logic_src/RingDoor.gd'

var _door : RingDoor

func before() -> void:
	_door = RingDoor.new()
	
func test_is_movable() -> void:
	assert_bool(_door.is_movable()).is_false()
