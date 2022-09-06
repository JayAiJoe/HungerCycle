# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name StafferTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Staffer.gd'

var  _staffer : Staffer

func before() -> void:
	_staffer = auto_free(Staffer.new())
	
func test_set_staffer_data() -> void:
	assert_int(_staffer.get_SID()).is_equal(0)

func test_get_SID() -> void:
	assert_int(_staffer.get_SID()).is_equal(0)

func test_get_name() -> void:
	assert_str(_staffer.get_name()).is_equal("Staffer")

func test_get_skill_name() -> void:
	assert_str(_staffer.get_skill_name()).is_equal("Staffer Skill")

func test_get_skill_element() -> void:
	assert_int(_staffer.get_skill_element()).is_equal(1)

func test_get_skill_cost() -> void:
	assert_int(_staffer.get_skill_cost()).is_equal(5)

func test_get_skill_effects() -> void:
	assert_array(_staffer.get_skill_effects()).is_empty()

func test_activate_skill() -> void:
	# remove this line and complete your test
	assert_not_yet_implemented()
