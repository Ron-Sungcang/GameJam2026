class_name Map
extends Node2D

const SCROLL_SPD := 15
const MAP_ICON = preload("res://scenes/maps/icon_room.tscn")
const MAP_CONNECTOR = preload("res://scenes/maps/icon_connector.tscn")

@onready
var map_generator: MapGenerator = $mapGenerator
@onready
var lines: Node2D = %Line
@onready
var icons: Node2D = %Icon
@onready
var visual: Node2D = $Visual
@onready
var camera: Camera2D = $Camera2D

var map_array: Array[Array]
var floors_climbed: int
var last_room: MapIconInfo
var camera_y: float

func _ready() -> void:
	camera_y = MapGenerator.Y_DIST * (MapGenerator.FLOORS - 1)
	
	generate_new_map()
	unlock_floor(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		camera.position.y -= SCROLL_SPD
	elif event.is_action_pressed("scroll_down"):
		camera.position.y += SCROLL_SPD
	camera.position.y = clamp(camera.position.y, -camera_y, 0)

func generate_new_map() -> void:
	floors_climbed = 0
	map_array = map_generator.generate_map()
	create_map()

func create_map() -> void:
	for curr_floor in map_array:
		for icon: MapIconInfo in curr_floor:
			if icon.next_icons.size() > 0:
				create_icon(icon)
				
	# For the boss room
	var middle := floori(MapGenerator.MAP_WIDTH/2.0)
	create_icon(map_array[MapGenerator.FLOORS-1][middle])
	
	var map_width_pixels := MapGenerator.X_DIST * (MapGenerator.MAP_WIDTH - 1)
	visual.position.x = (get_viewport_rect().size.x - map_width_pixels) / 2
	visual.position.y = get_viewport_rect().size.y / 2

func unlock_floor(n: int = floors_climbed) -> void:
	for map_icon: AreaIcon in icons.get_children():
		if map_icon.room_icon.row == n:
			map_icon.available = true

func unlock_next_icons() -> void:
	for map_icon: AreaIcon in icons.get_children():
		if last_room.next_icons.has(map_icon.room_icon):
			map_icon.available = true

func show_map() -> void:
	show()
	camera.enabled = true

func hide_map() -> void:
	hide()
	camera.enabled = false

func create_icon(icon: MapIconInfo) -> void:
	var new_icon := MAP_ICON.instantiate() as AreaIcon
	icons.add_child(new_icon)
	new_icon.room_icon = icon
	new_icon.selected.connect(_on_map_room_selected)
	
	if icon.selected and icon.row < floors_climbed:
		new_icon.show_selected()

func connect_lines(icon: MapIconInfo) -> void:
	if icon.next_icons.is_empty():
		return
	
	for next: MapIconInfo in icon.next_icons:
		var new_line := MAP_CONNECTOR.instantiate() as Line2D
		new_line.add_point(icon.position)
		new_line.add_point(next.position)
		lines.add_child(new_line)

func _on_map_room_selected(icon: MapIconInfo) -> void:
	for map_icon: AreaIcon in icons.get_children():
		if map_icon.room_icon.row == icon.row:
			map_icon.available = false
	
	last_room = icon
	floors_climbed += 1
	unlock_next_icons()
	#hide_map()
