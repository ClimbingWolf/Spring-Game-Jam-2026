extends Node2D
var conveyor_speed = 400;
var pushback_speed = 20;
@export var rotationString = "down"
#func _process(delta: float) -> void:
var push_list = {}
var pos_list = {}

func _ready() -> void:
	$AnimatedSprite2D.animation = rotationString
	if(rotationString=="down"):
		$CollisionRotator.rotation_degrees = 0;
		
	elif(rotationString=="up"):
		$CollisionRotator.rotation_degrees = 180;
	elif(rotationString=="left"):
		$CollisionRotator.rotation_degrees = 90;
	elif(rotationString=="right"):
		$CollisionRotator.rotation_degrees = 270;
		
	$AnimatedSprite2D.play()
func _process(delta: float) -> void:
	for i in push_list.keys():
		if(i.linear_velocity != push_list[i]):
			i.linear_velocity = push_list[i]
		if(push_list[i].y == 0):
			i.linear_velocity = Vector2(i.linear_velocity.x, (global_position.y - i.global_position.y)*pushback_speed)
		if(push_list[i].x == 0):
			i.linear_velocity = Vector2((global_position.x - i.global_position.x)*pushback_speed, i.linear_velocity.y)
			

func _on_area_2d_body_entered(rbody: Node2D) -> void:
	if(rbody.get_parent().has_meta("itemName")):
		
		
		var body: RigidBody2D = rbody
		if(rotationString == "down"):
			push_list[body]= Vector2(0,1) * conveyor_speed
			body.global_position.x = global_position.x
			
		elif(rotationString == "up"):
			push_list[body]= Vector2(0,-1) * conveyor_speed
			body.global_position.x = global_position.x
		elif(rotationString == "left"):
			body.global_position.y = global_position.y
			push_list[body] = Vector2(-1,0) * conveyor_speed
		elif(rotationString == "right"):
			body.global_position.y= global_position.y
			push_list[body] = Vector2(1,0) * conveyor_speed
				
		rbody.get_parent().set_meta("conveyorCount", rbody.get_parent().get_meta("conveyorCount") + 1)
	pass # Replace with function body.
	




func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.get_parent().has_meta("itemName")):
		print("exit")
		push_list.erase(body)
		body.get_parent().set_meta("conveyorCount", body.get_parent().get_meta("conveyorCount") - 1)
		if(body.get_parent().get_meta("conveyorCount") == 0):
			body.linear_velocity = Vector2(0,0);
		
	
