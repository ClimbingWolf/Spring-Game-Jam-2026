extends Node2D

@onready var item_path = load("res://item.tscn")
@onready var detector = $Detector
@onready var timer = $Timer
@onready var item_holder = $ItemHolder

# if free to create new item, create one
func _on_detector_detected(destination: Node2D) -> void:
	var item = item_path.instantiate()
	item_holder.add_child(item)
	destination.receive_item(item)
	timer.start()

# detects if its free to create new item
func _on_timer_timeout() -> void:
	detector.detect()
