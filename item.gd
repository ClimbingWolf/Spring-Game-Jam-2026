extends Sprite2D

@export var base_value = 5
@export var multiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_base_value(value):
	base_value += value

func add_multiplier(multiplier):
	self.multiplier += multiplier

func get_value():
	return base_value * multiplier
