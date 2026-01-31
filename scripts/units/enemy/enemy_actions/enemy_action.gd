extends Node

class_name enemy_action

var action_res: enemy_action_res

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(res: enemy_action_res) -> void:
	action_res = res
