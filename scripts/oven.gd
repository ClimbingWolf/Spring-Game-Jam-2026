extends Area2D

@onready var item_holder = $ItemHolder
@onready var detector = $Detector
@onready var sprite = $Sprite2D

enum Direction {LEFT, DOWN, UP, RIGHT}

@export var direction: Direction = Direction.LEFT
@export var speed: int = 30
@export var give_value = 5

# sets the sprite of the conveyor and offsets detector to where coneyor is facing
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
			
# sets sprite on ready
func _ready() -> void:
	setup()
	item_holder.remove_items()
	item_holder.speed = speed
	sprite.speed_scale = speed / 30 * 2

# checks if conveyor is already holding an item
func can_receive_item() -> bool:
	return item_holder.get_child_count() == 0

# receives item
func receive_item(item: Node2D):
	item_holder.receive_item(item)

# if the detected signal activates, receive the next item
func _on_detector_detected(area: Area2D):
	var item = item_holder.get_item()
	area.receive_item(item)

# if item is held, detect if item can move
func _on_item_holder_item_held():
	var item = item_holder.get_item()
	item.base_value += give_value
	item.self_modulate = Color(0.5, 0.5, 0.5, 1.0)
	sprite.play("default")
	detector.detect()
