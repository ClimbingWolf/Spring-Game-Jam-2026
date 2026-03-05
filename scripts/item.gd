extends AnimatedSprite2D

@onready var items = {
	"tomato" : 0,
	"orange" : 1,
	"banana" : 2,
	"fruit_basket" : 3
}

@export var base_value = 5
@export var multiplier = 1
@export var type = "tomato"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frame = items[type]
	pass

func add_base_value(value):
	base_value += value

func add_multiplier(multiplier):
	self.multiplier += multiplier

func get_value():
	return base_value * multiplier
