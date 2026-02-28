extends Node2D

#Loading the images elsewhere would probably be better

var apple = load("res://temporary_images/images (6).jpg")
var banana = load("res://temporary_images/pngimg.com - banana_PNG824.png")

func _process(delta: float) -> void:
	var name = get_meta("itemName")
	if(name=="apple"):
		$Sprite2D.texture = apple
	elif (name =="banana"):
		$Sprite2D.texture = banana
