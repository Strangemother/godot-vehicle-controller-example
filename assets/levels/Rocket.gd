extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var node 
var engine = preload("res://assets/engine.tscn")

func _input(event):
	
	if Input.is_action_pressed("A_Button"):
		var new_one = engine.instance()	
		new_one.key_thrust = 'Trigger_Right'
		var rpath = get_path()
		new_one.rocket_node = NodePath(rpath)
		add_child(new_one)
# Called every frame. 'delta' is the elapsed time since the previous frame.
