extends Area2D

@onready var item_holder = $ItemHolder

var value_held = 0

func can_receive_item() -> bool:
	#return true
	return item_holder.get_child_count() == 0

func receive_item(item: Node2D):
	item_holder.receive_item(item)

func _on_item_holder_item_held() -> void:
	var item = item_holder.get_item()
	value_held += item.get_value()
	item.queue_free()
