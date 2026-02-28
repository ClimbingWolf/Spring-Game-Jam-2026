extends Node2D
@export var number_of_inputs = 1
var conveyor_node_scene: PackedScene = preload("res://scenes/machine/conveyor_node.tscn")
var item_scene: PackedScene = preload("res://scenes/item.tscn")
@export var node_height_dist = 100;
@export var inputs_x_dist = 100;
@export var number_of_outputs = 1;
signal run_machine;
var inputs = []
var outputs = []

func _ready():
	for i in range(number_of_inputs):
		var y = (-number_of_inputs/2 + i) * (node_height_dist/number_of_inputs)
		var x = inputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		conveyor_node_scene_instance.set_meta("input", "apple")
		#This will need to be replaced with a better input later
		inputs.append(conveyor_node_scene_instance)
	for i in range(number_of_outputs):
		var y = (-number_of_outputs/2 + i) * (node_height_dist/number_of_outputs)
		var x = -inputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		conveyor_node_scene_instance.set_meta("output", "banana")
		outputs.append(conveyor_node_scene_instance)

func _process(delta: float) -> void:
	print(check_ready())
	print(inputs)
	if(check_ready()):
		emit_signal("run_machine")
		for i:Node2D in outputs:
			var new_item: Node2D = item_scene.instantiate();
			new_item.position = i.position
			new_item.set_meta("itemName", i.get_meta("output"))
			


func check_ready():
	var all_inputs_ready = true
	for i: Node2D in inputs:
		if(not i.get_meta("ready")):
			all_inputs_ready = false
	return all_inputs_ready
	
