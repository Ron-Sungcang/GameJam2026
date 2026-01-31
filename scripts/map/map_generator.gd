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

var random_room_type_total_weight := 0
var map_array: Array[Array]
