extends Spatial
class_name Ring3D

export var RingAvatar = preload("res://3D_environment/CharacterAvatar.tscn")

var characters = []

func _ready() -> void:
	for i in range(4):
		var ca = RingAvatar.instance()
		ca.set_data(i + 1)
		characters.append(ca)
		add_child(ca)
		ca.move_along_circle(i * 90.0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				rotate_ring(1)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				rotate_ring(-1)
		

# rotates the ring 1 unit in the specified direction
# 1 clockwise, -1 counterclockwise
func rotate_ring(direction : int) -> void:
	for c in characters:
		c.go_to_angle(c.get_current_angle() + direction * 90)

		

func get_angles(count : int, offset : float = 0.0) -> Array:
	var spacing = 360.0 / count
	var res = []
	for i in count:
		res.append(i * spacing + offset)
	return res
