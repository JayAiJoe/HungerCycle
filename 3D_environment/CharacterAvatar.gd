extends Spatial
class_name CharacterAvatar


export var rotation_speed = PI
export var radius = 2.5

var curr_deg = 0.0
var tween_locked := false

func _ready() -> void:
	pass

func _process(delta):
	pass

func get_current_angle() -> float:
	return curr_deg

func get_radius() -> float:
	return radius

func set_data(id : int) -> void:
	#TODO : connect to character database
	$Sprite3D.texture = load("res://assets/samplechar/char" + str(id) + ".png")

# animate movement towards new angle
# lock_override is for high priority calls such as spawning
func go_to_angle(new_angle : float, time : float = 0.3, lock_override : bool = false, new_radius : float = radius) -> void:
	if not tween_locked or lock_override:
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		var temp = curr_deg
		tween_locked = true
		if new_angle - temp > 180.0:
			new_angle -= 360
		tween.tween_method(self, "move_along_circle", temp, new_angle, time)
		tween.parallel().tween_property(self, "radius", new_radius, time)
		yield(tween, "finished")
		tween_locked = false


func move_along_circle(new_deg : float) -> void:
	curr_deg = fmod(new_deg, 360)
	var x = cos(deg2rad(curr_deg) ) * radius
	var z = sin(deg2rad(curr_deg) ) * radius
	translation = Vector3(x,0,z)
