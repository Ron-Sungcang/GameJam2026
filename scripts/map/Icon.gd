extends Node2D

@export
var icon_info : MapIconInfo

@onready
var sprite := $Area2D/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if icon_info and icon_info.sprite:
		sprite.texture = icon_info.sprite 
