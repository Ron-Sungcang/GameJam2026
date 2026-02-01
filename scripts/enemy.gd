class_name Enemy extends TextureButton


#@export var damage: int = 15
@export var data: BattleActor = null :
	set(value):
		data = value
		#update sprite
		#etc

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("RESET")
	

func _on_focus_entered() -> void:
	animation_player.play("highlight")

func _on_focus_exited() -> void:
	animation_player.play("RESET")
