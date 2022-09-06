# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name CustomerTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Customer.gd'

var _customer : Customer

func before() -> void:
	_customer = Customer.new()
	
func test_set_customer_data() -> void:
	assert_int(_customer.get_CTID()).is_equal(0)

func test_get_CTID() -> void:
	assert_int(_customer.get_CTID()).is_equal(0)

func test_get_name() -> void:
	assert_str(_customer.get_name()).is_equal("Customer")

func test_get_order() -> void:
	assert_array(_customer.get_order()).contains_exactly([2,0,0,0])

func test_get_max_order() -> void:
	assert_array(_customer.get_max_order()).contains_exactly([3,0,0,0])

func test_get_restrictions() -> void:
	assert_array(_customer.get_restrictions()).contains_exactly([1,2,3])

func test_get_gold() -> void:
	assert_int(_customer.get_gold()).is_equal(10)

func test_get_tip() -> void:
	assert_int(_customer.get_tip()).is_equal(2)

func test_get_rep_reward() -> void:
	assert_int(_customer.get_rep_reward()).is_equal(5)

func test_get_effects() -> void:
	assert_array(_customer.get_effects()).is_empty()

func test_perform_effects() -> void:
	# remove this line and complete your test
	assert_not_yet_implemented()
