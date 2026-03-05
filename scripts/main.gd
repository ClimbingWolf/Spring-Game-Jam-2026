extends Node2D

var quota = 10
var points = 0
var max_distance = 4
var select = Vector2(max_distance,max_distance)
var machine_select = 1
var direction = 0
var machines = {}
var inventory = [null, null, null, null, null, null, null, null, null]

# starter inventory
func _ready() -> void:
	inventory[0] = $MachineDatabase.get_item("Start")
	var start2 = $MachineDatabase.get_item("Start")
	start2.type = "banana"
	var start3 = $MachineDatabase.get_item("Start")
	start3.type = "orange"
	inventory[1] = start2
	inventory[2] = start3
	inventory[3] = $MachineDatabase.get_item("Conveyor")
	inventory[4] = $MachineDatabase.get_item("Conveyor")
	inventory[5] = $MachineDatabase.get_item("Conveyor")
	inventory[6] = $MachineDatabase.get_item("Conveyor")
	inventory[7] = $MachineDatabase.get_item("Press")
	inventory[8] = $MachineDatabase.get_item("Oven")

func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	mouse_pos = Vector2(round(mouse_pos.x / 32), round(mouse_pos.y / 32))
	if abs(mouse_pos.x) <= max_distance and abs(mouse_pos.y) <= max_distance and mouse_pos != Vector2(0,0):
		select = mouse_pos

	$Selection.position = select * 32
	
	points += $End.value_held
	$End.value_held = 0
	
	$Camera2D/PointDisplay.text = str(points)# + "/" + str(quota)
	
	for child in $"Camera2D/Inventory".get_children():
		if child.name == str(machine_select):
			child.self_modulate = Color(0.5, 0.5, 0.5, 1.0)
		else:
			child.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		
		var icon_sprite = child.get_child(0)
		var inventory_item = inventory[int(child.name) - 1]
		if inventory_item != null:
			var inventory_item_sprite = inventory_item.get_child(0)
			if inventory_item_sprite.get_class() == "AnimatedSprite2D":
				icon_sprite.texture = inventory_item_sprite.get_sprite_frames().get_frame_texture("default", 0)
			elif inventory_item_sprite.get_class() == "Sprite2D":
				icon_sprite.texture = inventory_item_sprite.texture
		else:
			icon_sprite.set_texture(null)

func place_selected():
	if not machines.has(select):
		if inventory[machine_select - 1] != null:
			var machine = inventory[machine_select - 1]
			inventory[machine_select - 1] = null
			match direction:
				0:
					machine.direction = machine.Direction.LEFT
				1:
					machine.direction = machine.Direction.UP
				2:
					machine.direction = machine.Direction.RIGHT
				3:
					machine.direction = machine.Direction.DOWN
			machine.global_position = select * 32
			machine._ready()
			machines[select] = machine
			$Machines.add_child(machine)
			
func remove_selected():
	if inventory[machine_select - 1] == null:
		if machines.has(select):
			inventory[machine_select - 1] = machines[select]
			$Machines.remove_child(machines[select])
			machines.erase(select)
			
func selection_update():
	var label = $Camera2D/NameLabel
	var timer = $Camera2D/NameLabel/Timer
	if(inventory[machine_select - 1] == null):
		label.text = ""
	else:
		label.text = inventory[machine_select - 1].name
	label.position = Vector2(get_node("Camera2D/Inventory/" + str(machine_select)).position.x - 84, 85)
	label.visible = true
	timer.start()
	await(timer.timeout)
	label.visible = false

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
	if event.is_action_pressed("shift_left"):
		machine_select -= 1
		if machine_select < 1:
			machine_select = 9
		selection_update()
	if event.is_action_pressed("shift_right"):
		machine_select += 1
		if machine_select > 9:
			machine_select = 1
		selection_update()
	if event.is_action_pressed("select"):
		place_selected()
	if event.is_action_pressed("cancel"):
		remove_selected()
	for i in range(1, 10):
		if event.is_action_pressed(str(i)):
			machine_select = i
			selection_update()
