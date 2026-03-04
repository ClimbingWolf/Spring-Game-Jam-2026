extends Area2D

@onready var item_holder = $ItemHolder
@onready var detector = $Detector
@onready var sprite = $Sprite2D

enum Direction {LEFT, DOWN, UP, RIGHT}

@export var direction: Direction = Direction.LEFT

# sets the sprite of the conveyor and offsets detector to where coneyor is facing
func set_direction():
	match direction:
		Direction.LEFT:
			detector.position = Vector2(-32, 0)
			sprite.play("left")
		Direction.DOWN:
			detector.position = Vector2(0, 32)
			sprite.play("down")
		Direction.UP:
			detector.position = Vector2(0, -32)
			sprite.play("up")
		Direction.RIGHT:
			detector.position = Vector2(32, 0)
			sprite.play("right")
			
# sets sprite on ready
func _ready() -> void:
	set_direction()

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
	detector.detect()
