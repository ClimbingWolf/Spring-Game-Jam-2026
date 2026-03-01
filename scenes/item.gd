extends Node2D

@export var default_item_name:String = "apple";

#Loading the images elsewhere would probably be better

var apple = load("res://temporary_images/images (6).jpg")
var banana = load("res://temporary_images/pngimg.com - banana_PNG824.png")
var brick = load("res://temporary_images/images (7).jpg")

func _ready() -> void:
	#set_meta("itemName", default_item_name)
	set_meta("conveyorCount", 0)
	set_meta("ready", false)

func _process(delta: float) -> void:
	var name = get_meta("itemName")
	if(name=="apple"):
		$RigidBody2D/Sprite2D.texture = apple
	elif (name =="banana"):
		$RigidBody2D/Sprite2D.texture = banana
	elif (name =="brick"):
		$RigidBody2D/Sprite2D.texture = brick
