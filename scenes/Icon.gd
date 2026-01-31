extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exit)

func _on_mouse_entered() -> void:
	print("Mouse entered icon.")
	
func _on_mouse_exit() -> void:
	print("Mouse exited icon")

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Clicked icon")
