extends Node2D
var input_lock = false
var current_item: Node2D = null
func _ready() -> void:
	set_meta("ready", false)
	set_meta("held_item", null)
