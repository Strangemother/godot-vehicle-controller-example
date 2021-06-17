extends Spatial

export(bool) var enabled = true
export(NodePath) var node
export(Vector3) var offset
export var tether_length = 15
export var teather_strength = 250

func _ready():
	node = get_node(node)

func _physics_process(delta):
	
	if not enabled: return 
	if not node:
		return 
	var node_pos = node.get_global_transform().origin
	var my_pos = get_global_transform().origin
	look_at(node_pos,Vector3(0,1,0))
	if my_pos.distance_to(node_pos) > tether_length:
		node.add_force(-my_pos.direction_to(node_pos)*teather_strength,
		node_pos+offset-my_pos)
