extends VehicleWheel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect('wheel_friction_slip', self, "_init_on_VehicleBody_wheel_friction_slip")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init_on_VehicleBody_wheel_friction_slip(value):
	print('Wheel heard friction slip ', self, value)
	self.wheel_friction_slip = value
