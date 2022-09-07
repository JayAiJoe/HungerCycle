# TurnManager.gd
# Manages turn phase Signals

extends Object
class_name TurnSignaler

var _current_phase

func _init() -> void:
	start_game()

func get_current_phase() -> int:
	return _current_phase
	
func go_to_next_phase() -> void:
	if _current_phase == Enums.Phases.GAME_START or _current_phase == Enums.Phases.TURN_END:
		_current_phase = Enums.Phases.TURN_START
	elif _current_phase == Enums.Phases.TURN_START:
		_current_phase = Enums.Phases.PLAY_PHASE
	elif _current_phase == Enums.Phases.PLAY_PHASE:
		_current_phase = Enums.Phases.TURN_END
	Events.emit_signal("phase_changed", _current_phase)

func start_game() -> void:
	_current_phase = Enums.Phases.GAME_START
	Events.emit_signal("phase_changed", _current_phase)

func end_game() -> void:
	_current_phase = Enums.Phases.GAME_END
	Events.emit_signal("phase_changed", _current_phase)
