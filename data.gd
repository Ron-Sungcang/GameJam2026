extends Node

var party: Array = [preload("res://Players/player.tres")]
var flags: Dictionary = {}
var rooms: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func load_resources_to_dict(path: String, dict: Dictionary) -> void:
	var dir: DirAccess = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				dict[file_name.replace(".tres", "")] = load(path + file_name)
				
			file_name = dir.get_next()
	else:
		print("An error occured when trying to access the path.")
