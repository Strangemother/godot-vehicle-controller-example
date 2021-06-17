extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
	
export var nodes_group_name = 'bodies'
export var indicator = preload("res://assets/Indicator.tscn")

var fields = ['x', 'y', 'z']
onready var nodes
# Called when the node enters the scene tree for the first time.
func _ready():
	indicator = indicator.instance()
	add_child(indicator)
	set_nodes_group(nodes_group_name)
	
func set_nodes_group(name):
	nodes = get_tree().get_nodes_in_group(name)

static func sum(array):
	var sum = 0.0
	for element in array:
		 sum += element
	return sum


func _process(delta):
	indicator.translation = center_of_mass(nodes)

func center_of_mass(items):
	# Calculate the center of mass for all units, returning a vector 
	# to use a transform displacement
	# a point particle of mass.
			
	# (mass * distance) + .. all items
	# Divide by total mass
	# x, y, z
	var total_masses = [12,2,3]
	var v_store = Vector3(0,0,0)
	var total_mass:int = sum(total_masses)
	# loop masses and add the fields to the
	# store for each engine position
	for i in range(0, len(total_masses)):
		for field in fields:
			var val = items[i].translation[field]
			v_store[field] += total_masses[i] * val
	return v_store / total_mass
