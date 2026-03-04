extends Node2D

var max_distance = 4
var select = Vector2(0,0)
var direction = 0
var machines = {}

func _ready() -> void:
	pass # Replace with function body.

# move camera if selection is far enough
func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	mouse_pos = Vector2(round(mouse_pos.x / 32), round(mouse_pos.y / 32))
	if abs(mouse_pos.x) <= max_distance and abs(mouse_pos.y) <= max_distance:
		select = mouse_pos

	$Selection.position = select * 32
	"""
	if (($Camera2D.position / 16 - select).length() > 2):
		$Camera2D.position += (select * 16 - $Camera2D.position).normalized() * delta * 128
	"""

func place_tile():
	$TileMapLayer.set_cell(select, 0, Vector2(0,0))
	
func remove_tile():
	$TileMapLayer.set_cell(select, -1, Vector2(0,0))

# places conveyor with direction of last movement
func place_conveyor():
	if not machines.has(select):
		var machine = $MachineDatabase.get_item("Conveyor", select * 32)
		match direction:
			0:
				machine.direction = machine.Direction.LEFT
			1:
				machine.direction = machine.Direction.UP
			2:
				machine.direction = machine.Direction.RIGHT
			3:
				machine.direction = machine.Direction.DOWN
		machines[select] = machine
		$Machines.add_child(machine)
	
func remove_conveyor():
	if machines.has(select):
		$Machines.remove_child(machines[select])
		machines.erase(select)
	
func _input(event):
	if event.is_action_pressed("turn"):
		direction += 1
		if direction == 5:
			direction = 0
	if event.is_action_pressed("d_left"):
		direction = 0
	if event.is_action_pressed("d_up"):
		direction = 1
	if event.is_action_pressed("d_right"):
		direction = 2
	if event.is_action_pressed("d_down"):
		direction = 3
	if event.is_action_pressed("select"):
		place_conveyor()
	if event.is_action_pressed("cancel"):
		remove_conveyor()
