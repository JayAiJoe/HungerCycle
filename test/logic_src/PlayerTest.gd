# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name PlayerTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://logic_src/Player.gd'

var _player : Player
var starting : Deck
var draw_pile : Pile
var discard_pile : Pile
var hand : Hand

func before() -> void:
	_player = Player.new()
	starting = Deck.new()
	draw_pile = Pile.new()
	discard_pile = Pile.new()
	draw_pile.add_card(Card.new(1))
	draw_pile.add_card(Card.new(2))

func test_set_starting_deck() -> void:
	# remove this line and complete your test
	assert_not_yet_implemented()
