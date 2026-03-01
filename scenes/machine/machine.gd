extends Node2D
@export var number_of_inputs = 1
var conveyor_node_scene: PackedScene = preload("res://scenes/machine/conveyor_node.tscn")
var item_scene: PackedScene = preload("res://scenes/item.tscn")
@export var node_length_dist = 100
@export var inputs_x_dist = 0
@export var number_of_outputs = 1
@export var run_time_seconds = 3;
@export var sprites:SpriteFrames;
@export var outputs_x_dist = 100
@export var input1_name: String = "";
@export var input2_name: String = "";
signal run_machine;
var inputs = []
var outputs = []
var collider: CollisionShape2D
var cooking = false;
@export var outputName: String = ""



func _ready():
	$AnimatedSprite2D.sprite_frames = sprites;
	$RigidBody2D.max_contacts_reported = 10;
	collider = $RigidBody2D/CollisionShape2D
	for i in range(number_of_inputs):
		var x = (-number_of_inputs/2 + i) * (node_length_dist/number_of_inputs)
		var y = inputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		if(i==0 and input1_name != ""):
			conveyor_node_scene_instance.set_meta("input", input1_name)
		elif (i==1 and input1_name != ""):
			conveyor_node_scene_instance.set_meta("input", input2_name)
		else:
			conveyor_node_scene_instance.set_meta("input", "apple")
		#This will need to be replaced with a better input later
		inputs.append(conveyor_node_scene_instance)
	for i in range(number_of_outputs):
		var y = (-number_of_outputs/2 + i) * (node_length_dist/number_of_outputs)
		var x = -outputs_x_dist
		var conveyor_node_scene_instance: Node2D = conveyor_node_scene.instantiate()
		add_child(conveyor_node_scene_instance)
		conveyor_node_scene_instance.position = Vector2(x,y)
		if(outputName != ""):
			conveyor_node_scene_instance.set_meta("output", outputName)
		else:
			conveyor_node_scene_instance.set_meta("output", "banana")
		outputs.append(conveyor_node_scene_instance)
		
func _process(delta: float) -> void:
	var bodies = $RigidBody2D.get_colliding_bodies()
	print(bodies)
	var looping = true
	for i: Node2D in inputs:
		for j: RigidBody2D in bodies:
			
			if(j.get_parent().has_meta("itemName") and j.get_parent().get_meta("itemName") == i.get_meta("input") and not i.get_meta("ready") and looping and not j.get_meta("ready")):
				print("jesse")
				j.global_position = i.global_position
				j.collision_layer = 0
				j.collision_mask = 0
				j.set_meta("ready" , true)
				i.set_meta("ready", true)
				i.set_meta("held_node", j.get_parent())
				looping = false
	if(check_ready()):
		cooking = true
		$AnimatedSprite2D.animation = "active"
		$AnimatedSprite2D.play();
		for i: Node2D in inputs:
			print(i.get_meta("held_node"))
			var item: Node2D = i.get_meta("held_node")
			item.queue_free()
			i.set_meta("ready", false)
		await get_tree().create_timer(run_time_seconds).timeout 
		for i: Node2D in outputs:
			var item_instance: Node2D = item_scene.instantiate();
			item_instance.position = i.position
			item_instance.set_meta("itemName", i.get_meta("output"))
			add_child(item_instance)
		$AnimatedSprite2D.animation = "default"
		cooking = false

func check_ready():
	if(cooking):
		return false
	for i: Node2D in inputs:
		if(i.get_meta("ready") != true):
			return false;
	return true


	
