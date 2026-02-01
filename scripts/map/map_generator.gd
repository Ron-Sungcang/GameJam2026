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
	var starting_point := _get_starting_points()
	
	for j in starting_point:
		var current_j := j
		for i in FLOORS - 1:
			current_j = _setup_connection(i, current_j)
	
	_setup_boss_room()
	_setup_random_room_weights()
	_setup_room_types()
		
	return map_array

func _generate_initial_grid() -> Array[Array]:
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

func _get_starting_points() -> Array[int]:
	var y_coord: Array[int]
	var unique_points: int = 0
	
	while unique_points < 2:
		unique_points = 0
		y_coord = []
		for i in PATHS:
			var starting_point := randi_range(0, MAP_WIDTH - 1)
			if not y_coord.has(starting_point):
				unique_points += 1
			y_coord.append(starting_point)
	return y_coord
		
func _setup_connection(i: int, j: int) -> int:
	var next_icon: MapIconInfo
	var current_icon := map_array[i][j] as MapIconInfo
	
	while not next_icon or _would_cross_existing_path(i, j, next_icon):
		var random_j := clampi(randi_range(j - 1, j + 1), 0, MAP_WIDTH - 1)
		next_icon = map_array[i+1][random_j]
	current_icon.next_icons.append(next_icon)
	return next_icon.column
	
func _would_cross_existing_path(i: int, j: int, next: MapIconInfo) -> bool:
	var left_neighbour: MapIconInfo
	var right_neighbour: MapIconInfo
	
	if j > 0:
		left_neighbour = map_array[i][j-1]
	if j < MAP_WIDTH - 1:
		right_neighbour = map_array[i][j+1]
	
	if right_neighbour and next.column > j:
		for next_icon: MapIconInfo in right_neighbour.next_icons:
			if next_icon.column < next.column:
				return true
				
	if left_neighbour and next.column < j:
		for next_icon: MapIconInfo in left_neighbour.next_icons:
			if next_icon.column > next.column:
				return true
	
	return false

func _setup_boss_room() -> void:
	var middle := floori(MAP_WIDTH * 0.5)
	var boss_room := map_array[FLOORS -1][middle] as MapIconInfo
	
	for j in MAP_WIDTH:
		var current_icon = map_array[FLOORS - 2][j] as MapIconInfo
		if current_icon.next_icons:
			current_icon.next_icons = [] as Array[MapIconInfo]
			current_icon.next_icons.append(boss_room)
			
	boss_room.type = MapIconInfo.Type.BOSS

func _setup_random_room_weights() -> void:
	random_room_weights[MapIconInfo.Type.COMMON] = COMMON_WEIGHT
	random_room_weights[MapIconInfo.Type.REST] = COMMON_WEIGHT + REST_WEIGHT
	random_room_weights[MapIconInfo.Type.ELITE] = COMMON_WEIGHT + REST_WEIGHT + ELITE_WEIGHT
	
	random_room_type_total_weight = random_room_weights[MapIconInfo.Type.ELITE]
	
func _setup_room_types() -> void:
	for icon: MapIconInfo in map_array[0]:
		if icon.next_icons.size() > 0:
			icon.type = MapIconInfo.Type.COMMON
	
	# Last floor before the boss is always a campfire
	for icon: MapIconInfo in map_array[13]:
		if icon.next_icons.size() > 0:
			icon.type = MapIconInfo.Type.REST
	
	# rest of rooms
	for current_floor in map_array:
		for icon: MapIconInfo in current_floor:
			for next_icon: MapIconInfo in icon.next_icons:
				if next_icon.type == MapIconInfo.Type.NOT_ASSIGNED:
					_set_room_randomly(next_icon)
					
func _set_room_randomly(icon_to_set: MapIconInfo) -> void:
	var rest_below_4 := true
	var consecutive_rest := true
	var rest_on_13 := true
	
	var type_candidate: MapIconInfo.Type
	
	while rest_below_4 or consecutive_rest or rest_on_13:
		type_candidate = _get_random_room_type_by_weight()
		
		var is_rest := type_candidate == MapIconInfo.Type.REST
		var has_rest_parent := _room_has_parent_of_type(icon_to_set, MapIconInfo.Type.REST)
		
		rest_below_4 = is_rest and icon_to_set.row < 3
		consecutive_rest = is_rest and has_rest_parent
		rest_on_13 = is_rest and icon_to_set.row == 12
	
	icon_to_set.type = type_candidate

func _room_has_parent_of_type(icon: MapIconInfo, type: MapIconInfo.Type) -> bool:
	var parents: Array[MapIconInfo] = []
	
	# Left side
	if icon.column > 0 and icon.row > 0:
		var parent_candidate := map_array[icon.row - 1][icon.column - 1] as MapIconInfo
		if parent_candidate.next_icons.has(icon):
			parents.append(parent_candidate)
			
	if icon.row > 0:
		var parent_candidate := map_array[icon.row -1][icon.column] as MapIconInfo
		if parent_candidate.next_icons.has(icon):
			parents.append(parent_candidate)
	
	for parent: MapIconInfo in parents:
		if parent.type == type:
			return true
	
	return false	

func _get_random_room_type_by_weight() -> MapIconInfo.Type:
	var rand_roll := randf_range(0.0, random_room_type_total_weight)
	
	for type: MapIconInfo.Type in random_room_weights:
		if random_room_weights[type] > rand_roll:
			return type
	return MapIconInfo.Type.COMMON
