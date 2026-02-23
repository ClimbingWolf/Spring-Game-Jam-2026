extends Node2D
@export var number_of_inputs = 1
var conveyor_node_scene: PackedScene = preload("res://scenes/conveyor_node.tscn")
@export var node_height_dist = 100;
@export var inputs_x_dist = 100;
@export var number_of_outputs = 1;
func _ready():
	for i in range(number_of_inputs):
		var y = (-number_of_inputs/2 + i) * (node_height_dist/number_of_inputs)
		var x = inputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		conveyor_node_scene_instance.set_meta("Input", true)
	for i in range(number_of_outputs):
		var y = (-number_of_outputs/2 + i) * (node_height_dist/number_of_outputs)
		var x = -inputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		conveyor_node_scene_instance.set_meta("Input", false)
	
