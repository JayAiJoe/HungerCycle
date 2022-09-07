# CommandHandler.gd
# Contains in-game elements, processes commands and interfaces with events

extends Object
class_name CommandHandler

var _player : Player
var _ring : Ring
var _command_queue : Array


func _init() -> void:
	_player = Player.new()
	_ring = Ring.new()
	_command_queue = []
	
	Events.connect("card_played", self, "on_card_played")

#Getters
func get_player() -> Player:
	return _player

func get_ring() -> Ring:
	return _ring

func get_command_queue() -> Array:
	return _command_queue

func queue_command(command : Command) -> void:
	match(command.get_actor_code()):
			Enums.Actors.PLAYER:
				command.set_actor(_player)
			Enums.Actors.RING:
				command.set_actor(_ring)
			Enums.Actors.CURRENT_CHARACTER:
				command.set_actor(_ring.get_current_character())
	_command_queue.append(command)
	
	
func execute_queue() -> void:
	while _command_queue.size() > 0:
		var command = _command_queue.pop_front()
		command.execute()
		# TODO: fix yielding of commands
		#yield(command, "executed")
		#command.free()

func on_card_played(card : Card) -> void:
	for command in card.get_effects():
		queue_command(command)
	execute_queue()

