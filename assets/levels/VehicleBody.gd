extends VehicleBody

export var init_wheel_friction_slip = 30
export var power_multiplier = 100
export var brake_multiplier = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal wheel_friction_slip(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("wheel_friction_slip", init_wheel_friction_slip)
