extends Node

var enemy_resource: enemy_res
var current_hp: int
var enemy_skills: Array[enemy_action]

@export var unit_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func initialize(res_file: enemy_res):
	enemy_resource = res_file
	current_hp = enemy_resource.max_hp
	unit_sprite.texture = enemy_resource.unit_texture

func set_unit_actions(res_actions: Array[enemy_action_res]):
	enemy_skills = res_actions as Array[enemy_action]

func get_unit_name() -> String:
	return enemy_resource.unit_name

func get_unit_attack() -> int:
	return enemy_resource.unit_attack

func get_unit_max_speed() -> int:
	return enemy_resource.unit_max_speed
	
func get_unit_min_speed() -> int:
	return enemy_resource.unit_min_speed
