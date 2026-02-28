extends Node2D
var input_lock = false
var current_item: Node2D = null
func _ready() -> void:
	get_parent().connect("run_machine", reset_on_signal);
	print(get_parent())
	$RigidBody2D.contact_monitor = true
	$RigidBody2D.max_contacts_reported = 10;
	set_meta("ready", false)
	
	



func _on_rigid_body_2d_body_entered(body: Node) -> void:
	var itemName = body.get_parent().get_meta("itemName")
	print(get_meta("input"))
	if(itemName != null and itemName == get_meta("input") and not input_lock):
		input_lock = true
		set_meta("ready", true)
		current_item = body
		print("READY")
		

func reset_on_signal():
	current_item.queue_free()
