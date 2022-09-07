extends Sprite

var starter_deck = [1,1,1,2,2,3]

var ch : CommandHandler
var player : Player
var ts : TurnSignaler

func _ready() -> void:
	ch = CommandHandler.new()
	player = ch.get_player()
	player.set_starting_deck_with_cids(starter_deck)
	player.set_deck_to_piles()
	ts = TurnSignaler.new()
	
	display_piles("start")
	
	ts.go_to_next_phase() # start turn 1
	display_piles("turn 1 - start")
	
	ts.go_to_next_phase() # play 
	player.play_card(player.get_hand().get_cards()[0])
	display_piles("played 1")
	
	ts.go_to_next_phase() # end
	display_piles("turn 1 - end")
	
	ts.go_to_next_phase() # start again
	display_piles("turn 2 - start")
	
	ts.go_to_next_phase() # play again
	display_piles("turn 2 - play")
	
	ts.go_to_next_phase() # end again
	display_piles("turn 2 - end")
	
	ts.go_to_next_phase() # start again
	display_piles("turn 3 - start")

func display_piles(msg : String = "") -> void:
	print(msg)
	print("draw: " + str(player.get_draw_pile().get_cards()))
	print("hand: " + str(player.get_hand().get_cards()))
	print("discard: " + str(player.get_discard_pile().get_cards()))
	print()
