extends Node2D



func rest() -> void:
	Global.player_health = Global.max_player_health
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rest_button_pressed() -> void:
	rest()
	# Do something to go back to 
