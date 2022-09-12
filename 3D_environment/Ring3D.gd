extends Spatial
class_name Ring3D

export var RingAvatar = preload("res://3D_environment/CharacterAvatar.tscn")

var characters := []
var door : CharacterAvatar
var current_character : CharacterAvatar

func _ready() -> void:
	randomize()
	initialize_door()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				rotate_ring(1)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				rotate_ring(-1)
	elif event.is_action_pressed("ui_accept"):
		add_new_character(randi() % 2 + 2)
	elif event.is_action_pressed("ui_down"):
		remove_character(characters[-1])

func initialize_door() -> void:
	door = RingAvatar.instance()
	door.set_data(1)
	characters.append(door)
	add_child(door)
	door.move_along_circle(90)
	current_character = door

# rotates the ring 1 unit in the specified direction
# 1 clockwise, -1 counterclockwise
func rotate_ring(direction : int) -> void:
	for c in characters:
		c.go_to_angle(c.get_current_angle() + direction * get_rotate_angle(), 0.1)
	var index = characters.find(current_character)
	index = (index + direction) % characters.size() # TODO: possible direction bug for current character focusing
	current_character = characters[index]

# adds a new character to the ring
func add_new_character(cid : int) -> void:
	var ca = RingAvatar.instance()
	ca.set_data(cid)
	characters.append(ca)
	add_child(ca)
	ca.move_along_circle(door.get_current_angle())
	adjust_ring_positions()

# removes the specified character from the ring
# cannot remove the door
func remove_character(ca : CharacterAvatar) -> void:
	if ca != door:
		characters.erase(ca)
		ca.queue_free()
		adjust_ring_positions()


# corrects the positions of characters currently in the ring
func adjust_ring_positions() -> void:
	var temp_door = door.get_current_angle()
	
	var new_positions = get_ring_positions(characters.size(), temp_door) # new positions with door as anchor
	for c_index in range(characters.size()): 
		characters[c_index].go_to_angle(new_positions[c_index], 0.3, true)
	
	
	
	
	

# returns the angle for 1 rotation
func get_rotate_angle() -> float:
	return 360.0 / characters.size()

# returns array of angular positions along the ring based on the number of characters
func get_ring_positions(count : int, offset : float = 0.0) -> Array:
	var spacing = 360.0 / count
	var res = []
	for i in count:
		res.append(i * spacing + offset)
	return res
