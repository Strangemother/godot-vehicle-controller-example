extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if mouse_enabled:
		handle_input_mouse(event)


func handle_input_mouse(event):
	if not event is InputEventMouseButton:
		return

	var ray_length = 1000
	var mouse_pos = event.position
	var camera = get_node("Camera")
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	print(from, to)
	var space_state = get_world().get_direct_space_state()
	# use global coordinates, not local to node
	# The result dictionary when a collision occurs contains the following data:
	#{
	#   position: Vector3 # point in world space for collision
	#   normal: Vector3 # normal in world space for collision
	#   collider: Object # Object collided or null (if unassociated)
	#   collider_id: ObjectID # Object it collided against
	#   rid: RID # RID it collided against
	#   shape: int # shape index of collider
	#   metadata: Variant() # metadata of collider
	#}
	var result = space_state.intersect_ray( from, to, [$entity/body])#, 2147483647, true, false)
	print(result)
