extends Node2D

var item_moving = false
@export var speed = 30
signal item_held

func remove_items():
	for item in get_children():
		remove_child(item)
		item.queue_free()

# receives next item
func receive_item(item: Node2D):
	if item != null:
		item.reparent(self, true)
		item_moving = true

# gets the item that it is holding
func get_item():
	return get_child(0)

# used to tell whether an item is held
func hold_item():
	item_moving = false
	emit_signal("item_held")

func _physics_process(delta: float) -> void:
	# if the item is not moving or no items are held, do nothing
	if not item_moving or get_child_count() == 0:
		return
	
	# get item held
	var item = get_child(0)
	
	# move item forward
	if item is Node2D:
		# move item to center
		item.global_position = item.global_position.move_toward(get_parent().global_position, speed * delta)
		
		# when item gets to center, hold it
		if item.global_position == get_parent().global_position:
			hold_item()
