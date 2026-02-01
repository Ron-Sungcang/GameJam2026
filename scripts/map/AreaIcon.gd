class_name AreaIcon
extends Area2D

signal selected(icon: MapIconInfo)

const ICONS := {
	MapIconInfo.Type.NOT_ASSIGNED: [null, Vector2.ONE],
	MapIconInfo.Type.COMMON: [preload("res://assets/Common_Icon.png"), Vector2(0.6,0.6)],
	MapIconInfo.Type.ELITE: [preload("res://assets/Elite_Icon.png"), Vector2(1.25,1.25)],
	MapIconInfo.Type.REST: [preload("res://assets/Rest_Icon.png"), Vector2(0.45,0.45)],
	MapIconInfo.Type.BOSS: [null, Vector2(1.25, 1.25)]
}

@onready
var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready
var line_2d: Line2D = $Visuals/Line2D
@onready
var animation_player: AnimationPlayer = $AnimationPlayer

var available := false : set = set_available
var room_icon: MapIconInfo : set = set_room

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if not available:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		room_icon.selected = true
		animation_player.play("select")

func set_available(new_value: bool) -> void:
	available = new_value
	
	if available:
		animation_player.play("highlight")
	elif not room_icon.selected:
		animation_player.play("RESET")

func set_room(new_data: MapIconInfo) -> void:
	room_icon = new_data
	position = room_icon.position
	line_2d.rotation_degrees = randi_range(0, 360)
	sprite_2d.texture = ICONS[room_icon.type][0]
	sprite_2d.scale = ICONS[room_icon.type][1]
	
func show_selected() -> void:
	line_2d.modulate = Color.WHITE

func _on_map_room_selected() -> void:
	selected.emit(room_icon)
