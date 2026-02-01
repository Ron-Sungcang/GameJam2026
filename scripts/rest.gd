extends Node2D

func rest() -> void:
	Global.player_health = Global.max_player_health	
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#hide()
	#Global.enter_rest.connect(_on_room_entered)
	pass # Replace with function body.

func hide_rest() -> void:
	hide()


func _on_room_entered() -> void:
	show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rest_button_pressed() -> void:
	rest()
	get_tree().change_scene_to_file("res://scenes/maps/map.tscn")
	#hide_rest()
	# Do something to go back to 
