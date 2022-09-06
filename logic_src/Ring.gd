# Ring.gd
# Container class for ring characters
# i.e. customers, staffers, etc. 

extends Object
class_name Ring

var _characters : Array
var _door : RingDoor

func _init() -> void:
	_characters = []
	_door = RingDoor.new()
	_door.set_left(_door)
	_door.set_right(_door)
	_characters.append(_door)

# return unordered list of characters
func get_characters() -> Array:
	return _characters

func get_character_count() -> int:
	return _characters.size()

func get_door() -> RingDoor:
	return _door

# return ordered list of characters starting from the door going right
func get_characters_in_order() -> Array:
	var res = [_door]
	var temp : RingCharacter = _door.get_right()
	while(temp != _door):
		res.append(temp)
		temp = temp.get_right()
	return res

# insert new character to the left of the specified character already in the ring
# default: insert to the left of the door
func insert_character_left(new_char : RingCharacter, ring_char : RingCharacter = _door) -> void:
	if ring_char in _characters:
		var temp = ring_char.get_left()
		ring_char.set_left(new_char)
		new_char.set_right(ring_char)
		new_char.set_left(temp)
		temp.set_right(new_char)
		_characters.append(new_char)

# insert new character to the right of the specified character already in the ring
# default: insert to the right of the door
func insert_character_right(new_char : RingCharacter, ring_char : RingCharacter = _door) -> void:
	if ring_char in _characters:
		var temp = ring_char.get_right()
		ring_char.set_right(new_char)
		new_char.set_left(ring_char)
		new_char.set_right(temp)
		temp.set_left(new_char)
		_characters.append(new_char)

# move a referenced ring character that is in the ring 1 space to the left 
func move_character_left(ring_char : RingCharacter) -> void:
	if ring_char in _characters and ring_char.is_movable():
		var temp_right = ring_char.get_right()
		var temp_left = ring_char.get_left()
		var temp_left_2 = ring_char.get_left().get_left()
		temp_right.set_left(temp_left)
		temp_left.set_right(temp_right)
		temp_left.set_left(ring_char)
		ring_char.set_right(temp_left)
		ring_char.set_left(temp_left_2)
		temp_left_2.set_right(ring_char)

# move a referenced ring character that is in the ring 1 space to the right
func move_character_right(ring_char : RingCharacter) -> void:
	if ring_char in _characters and ring_char.is_movable():
		var temp_left = ring_char.get_left()
		var temp_right = ring_char.get_right()
		var temp_right_2 = ring_char.get_right().get_right()
		temp_left.set_right(temp_right)
		temp_right.set_left(temp_left)
		temp_right.set_right(ring_char)
		ring_char.set_left(temp_right)
		ring_char.set_right(temp_right_2)
		temp_right_2.set_left(ring_char)

# remove a character from the ring by reference
func remove_character(ring_char : RingCharacter) -> void:
	if ring_char in _characters:
		var temp_left = ring_char.get_left()
		var temp_right = ring_char.get_right()
		temp_left.set_right(temp_right)
		temp_right.set_left(temp_left)
		_characters.erase(ring_char)
