class_name MapGenerator
extends Node2D

const X_DIST := 30
const Y_DIST := 25
const RANDOMNESS := 5
const FLOORS := 15
const MAP_WIDTH := 7
const PATHS := 6
const COMMON_WEIGHT := 10.0
const REST_WEIGHT := 4.0
const ELITE_WEIGHT := 4.0


var random_room_weights = {
	MapIconInfo.Type.COMMON: 0.0,
	MapIconInfo.Type.REST: 0.0,
	MapIconInfo.Type.ELITE: 0.0
}

func _ready() -> void:
	generate_map()

var random_room_type_total_weight := 0
var map_array: Array[Array]

func generate_map() -> Array[Array]:
	map_array = _generate_initial_grid()
	
	return []

func _generate_initial_grid():
	var result: Array[Array] = []
	for i in FLOORS:
		var adjacent_rooms: Array[MapIconInfo] = []
		
		for j in MAP_WIDTH:
			var current_icon := MapIconInfo.new()
			var offset := Vector2(randf(), randf()) * RANDOMNESS
			current_icon.position = Vector2(j* X_DIST, i * -Y_DIST) + offset
			current_icon.row = i
			current_icon.column = j
			current_icon.next_icons = []
			
			if i == FLOORS - 1:
				current_icon.position.y = (i+1) * -Y_DIST
				
			adjacent_rooms.append(current_icon)
			
		result.append(adjacent_rooms)
	return result
