extends Area2D

signal detected
var detecting = false

func detect():
	detecting = true

func _physics_process(delta: float) -> void:
	# if not detecting, do nothing
	if not detecting:
		return
	
	# check if its free for the item to move
	var areas = get_overlapping_areas()
	for area in areas:
		if area.can_receive_item():
			emit_signal("detected", area)
			detecting = false
			break
