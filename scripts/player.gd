extends Node2D
@export var health := 100
@export var damage := 100
@export var magic := 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if health != 100:
		health = 100
	Global.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
