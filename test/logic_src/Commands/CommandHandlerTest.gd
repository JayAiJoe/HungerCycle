# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name CommandHandlerTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Commands/CommandHandler.gd'

var _ch :CommandHandler
var _test_command : Command


func before() -> void:
	_ch = CommandHandler.new()
	_test_command = DrawCommand.new()
	
func test_queue_command() -> void:
	_ch.queue_command(DrawCommand.new())
	_ch.queue_command(_test_command)
	assert_object(_test_command._actor).is_same(_ch._player)
	assert_array(_ch._command_queue).has_size(2)

func test_execute_queue() -> void:
	_ch.execute_queue()
	assert_signal(_test_command).is_emitted("executed")
	assert_array(_ch._command_queue).has_size(0)
	
func after() -> void:
	_ch.free()
