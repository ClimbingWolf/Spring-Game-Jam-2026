extends Node2D

var select = Vector2(0,0)
var machines = {}

enum Direction {LEFT, DOWN, UP, RIGHT}

var direction = Direction.LEFT

func _ready() -> void:
	pass # Replace with function body.

# move camera if selection is far enough
func _process(delta: float) -> void:
	if (($Camera2D.position / 16 - select).length() > 2):
		$Camera2D.position += (select * 16 - $Camera2D.position).normalized() * delta * 128

func place_tile():
	$TileMapLayer.set_cell(select, 0, Vector2(0,0))
	
func remove_tile():
	$TileMapLayer.set_cell(select, -1, Vector2(0,0))

# places conveyor with direction of last movement
func place_conveyor():
	if not machines.has(select):
		var machine = $MachineDatabase.get_item("Conveyor", select * 32)
		match direction:
			Direction.LEFT:
				machine.direction = machine.Direction.LEFT
			Direction.DOWN:
				machine.direction = machine.Direction.DOWN
			Direction.UP:
				machine.direction = machine.Direction.UP
			Direction.RIGHT:
				machine.direction = machine.Direction.RIGHT
		machines[select] = machine
		$Machines.add_child(machine)
	
func remove_conveyor():
	if machines.has(select):
		$Machines.remove_child(machines[select])
		machines.erase(select)
	
func _input(event):
	if event.is_action_pressed("up"):
		direction = Direction.UP
		select.y -= 1
	if event.is_action_pressed("down"):
		direction = Direction.DOWN
		select.y += 1
	if event.is_action_pressed("right"):
		direction = Direction.RIGHT
		select.x += 1
	if event.is_action_pressed("left"):
		direction = Direction.LEFT
		select.x -= 1
	if event.is_action_pressed("select"):
		place_conveyor()
	if event.is_action_pressed("cancel"):
		remove_conveyor()
