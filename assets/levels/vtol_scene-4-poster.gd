extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(_event):
	
	
	if Input.is_action_pressed("Reset"):
		pass#reset()

func reset():
	var rocket = get_node("Rocket")
	rocket.translation = Vector3(0, 4, 0)
	rocket.rotation_degrees = Vector3(0, 0, 0)
	rocket.linear_velocity = Vector3(0, 0, 0)
	rocket.angular_velocity = Vector3(0, 0, 0)
	
