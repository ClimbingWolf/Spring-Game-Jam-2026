extends Camera2D

@export var wasd_speed = 500
@export var zoom_scale = 1.05
@export var min_zoom = 1
@export var max_zoom = 3
@export var max_distance = 512

func _process(delta: float) -> void:
	var mult = delta * wasd_speed * 1 / zoom.x
	
	if position.length() > max_distance:
		translate(-position.normalized() * mult)
	else:
		if(Input.is_action_pressed("up")):
			translate(Vector2.UP * mult)
		if(Input.is_action_pressed("down")):
			translate(Vector2.DOWN * mult)
		if(Input.is_action_pressed("left")):
			translate(Vector2.LEFT * mult)
		if(Input.is_action_pressed("right")):
			translate(Vector2.RIGHT * mult)
	
	#$CanvasLayer/PointDisplay.scale = Vector2(zoom.x, zoom.y)
	#$PointDisplay.scale = zoom
		
		
func _input(event):
	pass
"	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom /= Vector2(1,1) * zoom_scale
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom *= Vector2(1,1) * zoom_scale
		if(zoom.x < min_zoom):
			zoom = Vector2(1,1) * min_zoom
		elif(zoom.x > max_zoom):
			zoom = Vector2(1,1) * max_zoom"
