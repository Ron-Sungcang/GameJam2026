extends Node

#Unit manager is in charge of global commands relating to unit between different scenes

#Array of units
@export var enemy_units_res: Array[enemy_res] #Exported for now, but later will get enemy count from stage

var enemy_units: Array[enemy_unit]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func load_enemy_res() -> void:
	for res in enemy_units_res:
		var load_res = res.unit_scene.instantiate() as enemy_unit
		enemy_units.append(load_res)
