extends Node

class_name combat_ui

@export var user_ui: PanelContainer
@export var action_button: Button #Normal button for testing, change to texture button later

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func disable_user_ui() -> void:
	print("Disabling combat UI...")
	user_ui.visible = false

func enable_user_ui() -> void:
	print("Enabling combat UI...")
	user_ui.visible = true

func set_button_action(action: Callable) -> void:
	action_button.pressed.connect(action)
	
