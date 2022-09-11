extends Node2D

const DRAW_POSITION := Vector2(120,900)
const HAND_POSITION := Vector2(960, 900)
const DISCARD_POSITION := Vector2(1800,900)

const HAND_X_OFFSET_UNIT := 175.0
const HAND_DEGREE_UNIT := 2.0
const HAND_Y_OFFSET_UNIT := 17.0
const VALID_COLOR := Color("A4DE02")

export var Card = preload("res://2D_interface/CardAvatar.tscn")

var draw := []
var hand := []
var discard := []
var all_cards := []

var hovered_cards : = []
var selected_card = null 

var line_start_position := Vector2(960, 540)
var line_end_position := Vector2(500,500)
var max_points := 50
onready var line = $TargetLine
onready var line_arrow = $LineArrow
var playable := false

func _ready() -> void:
	$CardPlayArea.connect("targeted", self, "set_playable")
	for i in range(10):
		var c = Card.instance()
		c.position = DRAW_POSITION
		add_child(c)
		draw.append(c)
		c.connect("hovered", self, "toggle_focus")
		c.connect("selected", self, "set_selected_card")
	
		
func _process(delta):
	if Input.is_mouse_button_pressed(1) and (hovered_cards.size() > 0 or selected_card):
		line.show()
		line_arrow.show()
		line_end_position = get_global_mouse_position()
		
		if hovered_cards.size() > 0:
			line_start_position = hovered_cards[0].position
		
		var count = line.get_point_count()
		if count > 1:
			line_arrow.rotation = line.get_point_position(count-1).angle_to_point(line.get_point_position(count-2))

		line_arrow.position = line_end_position
		update_trajectory(delta)
	else:
		line.hide()
		line_arrow.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.pressed:
					if hovered_cards.size() > 0:
						set_selected_card(hovered_cards[0])
				else:
					if selected_card and playable:
						regular_discard(selected_card)
					release_selected_card()
			BUTTON_RIGHT:
				if event.pressed:
					if hand.size() > 0:
							regular_discard(hand[0])

	elif event.is_action_pressed("ui_accept"):
		if draw.size() > 0:
			regular_draw()
		else:
			for c in discard:
				c.go_to_pile(DRAW_POSITION)
				draw.append(c)
				c.set_on_hand(false)
				yield(get_tree().create_timer(0.1), "timeout")
			discard.clear()


func update_trajectory(delta):
	line.clear_points()
	var pos = line_start_position
	
	for i in range(max_points):
		line.add_point(pos)
		pos = UtilsUi.quadratic_bezier(line_start_position, line_start_position - Vector2(0, 500), line_end_position, (i+1.0)/max_points)

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
	c.get_node("Visuals").rotation_degrees = new_hand_rotations[-1]
	c.hand_rotation = new_hand_rotations[-1]
	c.go_to_pile(new_hand_positions[-1])
	
	# z index
	for c_index in range(hand.size()):
		hand[c_index].set_hand_z_index(100 - c_index)

func regular_discard(card : CardAvatar) -> void:
	if card in hand:
		hand.erase(card)
		card.get_node("Visuals").rotation_degrees = 0.0
		card.hand_rotation = 0.0
		card.go_to_pile(DISCARD_POSITION)
		discard.append(card)
		card.set_on_hand(false)
		
		# center positions of remaining cards
		var new_hand_positions = get_hand_positions(hand.size())
		var new_hand_rotations = get_hand_rotation_degrees(hand.size())
		for c_index in range(hand.size()):
			hand[c_index].move_and_rotate(new_hand_positions[c_index], new_hand_rotations[c_index])


func get_hand_positions(count : int) -> Array:
	var hand_width = min(HAND_X_OFFSET_UNIT * (count-1), 1000)
	var right_most_pos = HAND_POSITION + Vector2(hand_width/2, 0)
	var mid = (count-1)/2.0
	var x_spacing = 0.0
	var res = []
	
	if count > 1:
		x_spacing = min(HAND_X_OFFSET_UNIT, hand_width/(count-1))
	for p in range(count):
		res.append(right_most_pos + p * Vector2(-x_spacing, 0) + abs(p-mid) * Vector2(0, HAND_Y_OFFSET_UNIT))
	
	return res

# TODO: Adjust rotation values
func get_hand_rotation_degrees(count : int) -> Array:
	var res = []
	var max_degree = HAND_DEGREE_UNIT * floor(count/2)
	for i in range(count):
		res.append(max_degree - HAND_DEGREE_UNIT * i)
	return res
	
func toggle_focus(card : CardAvatar, hovered : bool) -> void:
	if card.is_on_hand():
		
		for c in hand:
			if card != selected_card:
				c.slide_back()
		
		if hovered:
			if not card in hovered_cards:
				hovered_cards.append(card)
		else:
			if card != selected_card:
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
	

func set_selected_card(card : CardAvatar) -> void:
	if not selected_card:
		selected_card = card

func release_selected_card() -> void:
	if selected_card:
		selected_card.unfocus()
		for c in hand:
			c.slide_back()
	hovered_cards.erase(selected_card)
	selected_card = null

func set_playable(target : int, state : bool) -> void:
	# TODO: check target conditions (i.e. if playable against customer)
	playable = state
	if state:
		line_arrow.modulate = VALID_COLOR
		line.modulate = VALID_COLOR
	else:
		line_arrow.modulate = Color.white
		line.modulate = Color.white
