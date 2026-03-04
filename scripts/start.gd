extends Node2D

@onready var item_path = load("res://scenes/item.tscn")
@onready var detector = $Detector
@onready var timer = $Timer
@onready var item_holder = $ItemHolder

enum Direction {LEFT, DOWN, UP, RIGHT}

@export var direction: Direction = Direction.LEFT
@export var base_value = 5
@export var multiplier = 1
@export var sprite = ""
@export var create_items = true

func setup():
	match direction:
		Direction.LEFT:
			detector.position = Vector2(-32, 0)
		Direction.DOWN:
			detector.position = Vector2(0, 32)
		Direction.UP:
			detector.position = Vector2(0, -32)
		Direction.RIGHT:
			detector.position = Vector2(32, 0)
			
func _ready() -> void:
	setup()
	item_holder.remove_items()

# if free to create new item, create one
func _on_detector_detected(destination: Node2D) -> void:
	print("hi2")
	if create_items:
		print("hi")
		var item = item_path.instantiate()
		item.base_value = base_value
		item.multiplier = multiplier
		item_holder.add_child(item)
		destination.receive_item(item)
		timer.start()

# detects if its free to create new item
func _on_timer_timeout() -> void:
	detector.detect()
