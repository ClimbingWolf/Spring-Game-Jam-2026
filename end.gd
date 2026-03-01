extends Area2D

#@onready var detector = $Detector
@onready var item_holder = $ItemHolder

func can_receive_item() -> bool:
	return true
	#return item_holder.get_child_count() == 0

func receive_item(item: Node2D):
	item_holder.receive_item(item)

func _on_detector_detected(area: Area2D) -> void:
	var item = item_holder.get_item()
	item.queue_free()
