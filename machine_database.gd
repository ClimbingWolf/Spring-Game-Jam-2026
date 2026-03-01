extends Node2D

var machines = {}

# adds all machines to dictionary
func _ready() -> void:
	for child in get_children():
		machines[child.name] = child
		
	while get_child_count() > 0:
		remove_child(get_child(0))

# used to lookup machine and set position
func get_item(item_name, pos):
	if (machines.has(item_name)):
		var machine = machines[item_name].duplicate()
		machine.global_position = pos
		return machine
	return null
