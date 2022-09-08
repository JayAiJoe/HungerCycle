extends Node2D
class_name CardAvatar

signal hovered(card, state)

onready var cardsUI := get_parent()

var p0 : Vector2
var p1 : Vector2
var p2 : Vector2
var t : float

var on_hand : bool
var hand_z_index : int
var hand_rotation := 0.0

var animation_locked := false
var hovered := false

func _ready() -> void:
	set_process(false)
	t = 0.0
	on_hand = false
	

func set_on_hand(hand : bool) -> void:
	on_hand = hand

func is_on_hand() -> bool:
	return on_hand

func set_hand_z_index(index : int) -> void:
	hand_z_index = index
	z_index = index

func set_hidden(hidden : bool) -> void:
	$Visuals.visible = hidden

# activate the curved movement animation towards given location
# can modify the curve by giving a vector2 paramater for the pos of the middle point
# of the bezier curve relative to starting position and target location
func go_to_pile(location : Vector2, mid_point = null) -> void:
	unfocus()
	p0 = position
	p2 = location
	if mid_point:
		p1 = mid_point
	else:
		p1 = Vector2((position.x + location.x) * 2/5, position.y - 300)
	set_process(true)
	animation_locked = true

func focus() -> void:
	z_index = 100
	rotation = 0.0
	var tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Visuals, "position", Vector2(0, -50), 0.1)
	tween.tween_property($Visuals, "rotation", 0.0, 0.05)

func unfocus() -> void:
	z_index = hand_z_index
	var tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Visuals, "position", Vector2.ZERO, 0.1)
	tween.tween_property($Visuals, "rotation", hand_rotation, 0.05)

# slide visuals in the given direction
# 1 right, -1 left
func slide(direction : int = 1) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Visuals, "position", direction * Vector2(20,0), 0.1)

func slide_back() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Visuals, "position", Vector2.ZERO, 0.1)

func move_and_rotate(location : Vector2, degrees : float) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", location, 0.2)
	# TODO: Fix rotations
#	tween.tween_property(self, "rotation_degrees", degrees, 0.2)
#	hand_rotation = degrees

func _process(delta):
	t += delta * 2
	position = UtilsUi.quadratic_bezier(p0, p1, p2, t)
	if t >= 1.0:
		t = 0.0
		set_process(false)
		animation_locked = false


func _on_Area2D_mouse_entered() -> void:
	emit_signal("hovered", self, true)

func _on_Area2D_mouse_exited() -> void:
	emit_signal("hovered", self, false)
