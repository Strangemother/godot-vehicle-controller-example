extends Spatial

# these two material are for visual feedback only when the thruster is active active_mat will be set
var active_mat = preload("res://resources/materials/active_mat.tres")
var deactivate_mat = preload("res://resources/materials/deactive_mat.tres")

# all variables starting with key_ are setting the input keys from the Input Map Tab inside Project ...
# ... Settings Menu - e.g writing "ui_select" will create the specific action when either Y in xbox gamepad or ...
# ... Space in keyboard is pressed
export var key_thrust : String = ""
export var key_vertical_positive_rotation : String = ""
export var key_vertical_negative_rotation : String = ""
export var key_horizontal_positive_rotation : String = ""
export var key_horizontal_negative_rotation : String = ""

export(int) var rotation_strength_mutipler : int = 10.0 # defines the mutipler for the rotation of the engines itself 
export(int) var thruster_strength_multipler : int = 150 # defines the thruster push strength for the engine
export(NodePath) var rocket_node # defines the node path for the rocket node


var vertical_axis : float = 0.0 # keeps track of the aggregate value of the vertical rotation inputs, -1 to 1
var horizontal_axis : float = 0.0 # keeps track of the aggregate value of the horizontal rotation inputs, -1 to 1
var thruster_strength : float = 0.0 # keeps track of the thruster_key from the inputs, 0 to 1

func _ready():
	
	rocket_node = get_node(rocket_node) # re-grabbing node, prevents 'getting' errors when the node is parented to target
	if rocket_node == null:
		print(get_name()," - rocket_node path was not set correctly (engine input is disabled to prevent crash or conflict)")
		set_process(false)
		set_process_input(false)
		return
	
	if not rocket_node is RigidBody: # is the rocket_node assigned is of type RigidBody?
		print(get_name()," - assigned rocket isn't a rigidbody? (engine input is disabled to prevent crash or conflict)")
		set_process(false)
		set_process_input(false)

func _physics_process(delta):
	
	
	if thruster_strength > 0:
		$Mesh.material_override = active_mat
		# finds the 'direction' the thruster is pointing, I had based it on the y axis so it follows the basis.y 
		var force_direciton = get_global_transform().basis.y
		# add_force uses godot built in physics engine - adding up direction and relative global coordinates
		# rocket_node.add_force(force_direciton*thruster_strength,get_global_transform().origin-rocket_node.get_global_transform().origin)
		rocket_node.add_force(
			force_direciton*thruster_strength,
				get_global_transform().origin
				- rocket_node.get_global_transform().origin
			)
		
	
	else:
		$Mesh.material_override = deactivate_mat

	rotation_degrees.z -= vertical_axis*rotation_strength_mutipler
	rotation_degrees.x += horizontal_axis*rotation_strength_mutipler

func _input(_event):
	vertical_axis = Input.get_action_strength(key_vertical_positive_rotation) - Input.get_action_strength(key_vertical_negative_rotation)
	horizontal_axis = Input.get_action_strength(key_horizontal_positive_rotation) - Input.get_action_strength(key_horizontal_negative_rotation)
	thruster_strength = Input.get_action_strength(key_thrust) * 100
