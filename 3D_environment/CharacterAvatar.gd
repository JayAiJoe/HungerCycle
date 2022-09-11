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

func go_to_angle(new_angle : float, new_radius : float = radius) -> void:
	if not tween_locked:
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		var temp = curr_deg
		tween_locked = true
		tween.tween_method(self, "move_along_circle", temp, new_angle, 0.3)
		tween.parallel().tween_property(self, "radius", new_radius, 0.3)
		yield(tween, "finished")
		tween_locked = false

func move_along_circle(new_deg : float) -> void:
	curr_deg= fmod(new_deg, 360)
	var x = cos(deg2rad(curr_deg) ) * radius
	var y = sin(deg2rad(curr_deg) ) * radius
	translation = Vector3(x,0,y)
