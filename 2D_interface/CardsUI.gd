extends Node2D

const DRAW_POSITION := Vector2(120,900)
const HAND_POSITION := Vector2(960, 900)
const DISCARD_POSITION := Vector2(1800,900)

const HAND_OFFSET_UNIT := 150.0

var Card = preload("res://2D_interface/CardAvatar.tscn")

var draw := []
var hand := []
var discard := []
var all_cards := []

var hovered_cards : = []

func _ready() -> void:
	for i in range(10):
		var c = Card.instance()
		c.position = DRAW_POSITION
		add_child(c)
		draw.append(c)
		c.connect("hovered", self, "toggle_focus")



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				if draw.size() > 0:
					regular_draw()
				else:
					for c in discard:
						c.go_to_pile(DRAW_POSITION)
						draw.append(c)
						c.set_on_hand(false)
						yield(get_tree().create_timer(0.1), "timeout")
					discard.clear()
			BUTTON_RIGHT:
				if hand.size() > 0:
					regular_discard()

func regular_draw() -> void:
	var c = draw.pop_front()
	c.set_on_hand(true)
	c.set_hand_z_index(100 - hand.size())
	
	# adjust old cards to make space for new card
	var new_hand_positions = get_hand_positions(hand.size() + 1)
	var new_hand_rotations = get_hand_rotation_degrees(hand.size() + 1)
	for c_index in range(hand.size()):
		hand[c_index].move_and_rotate(new_hand_positions[c_index], new_hand_rotations[c_index])
	
	# add new card to hand
	hand.append(c)
	c.go_to_pile(new_hand_positions[-1])

func regular_discard() -> void:
	var c = hand.pop_front()
	c.go_to_pile(DISCARD_POSITION)
	discard.append(c)
	c.set_on_hand(false)
	
	# center positions of remaining cards
	var new_hand_positions = get_hand_positions(hand.size())
	var new_hand_rotations = get_hand_rotation_degrees(hand.size())
	for c_index in range(hand.size()):
		hand[c_index].move_and_rotate(new_hand_positions[c_index], new_hand_rotations[c_index])

func get_hand_positions(count : int) -> Array:
	var hand_width = min(HAND_OFFSET_UNIT * (count-1), 1000)
	var right_most_pos = HAND_POSITION + Vector2(hand_width/2, 0)
	var x_spacing = 0.0
	var res = []
	
	if count > 1:
		x_spacing = min(HAND_OFFSET_UNIT, hand_width/(count-1))
	for p in range(count):
		res.append(right_most_pos - p * Vector2(x_spacing, 0))
	
	return res

# TODO: Adjust rotation values
func get_hand_rotation_degrees(count : int) -> Array:
	var res = []
	var max_degree = 3 * floor(count/2)
	for i in range(count):
		res.append(max_degree - 3 * i)
	return res

func get_hand_pos() -> Vector2:
	return HAND_POSITION + Vector2(450 - HAND_OFFSET_UNIT * (hand.size() - 1), 0)
	
func toggle_focus(card : CardAvatar, hovered : bool) -> void:
	if card.is_on_hand():
		
		for c in hand:
			c.slide_back()
		
		if hovered:
			hovered_cards.append(card)
		else:
			hovered_cards.erase(card)
			card.unfocus()
		if hovered_cards.size() > 0:
			var focused_card = hovered_cards[0]
			var focused_index = hand.find(focused_card)
			# slide for space
			if focused_index > 0:
				hand[focused_index - 1].slide(1)
			if focused_index < hand.size() -1:
				hand[focused_index + 1].slide(-1)
			# focus
			focused_card.focus()

	else:
		hovered_cards.erase(card)
	
