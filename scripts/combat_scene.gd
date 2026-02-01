extends Control

const Actions: Dictionary = EventQueue.Actions

var party: Array = Data.party
var action: EventQueue.Actions = -1
var current_player_index: int = -1

@onready var event_queue: Node = $EventQueue
@onready var options: PanelContainer = $MarginContainer/Options
@onready var player_windows: PlayerWindows = $MarginContainer/PlayerWindows
@onready var enemies: Menu = $Enemies


# Called when the node enters the scene tree for the first time."text"
func _ready() -> void:
	goto_next_player()

func goto_next_player(dir: int = 1) -> void:
	current_player_index += dir
	
	if current_player_index >= party.size():
		for enemy: Enemy in enemies.get_buttons():
			var actor: BattleActor = enemy.data
			var target: BattleActor = party.pick_random()
			event_queue.add(Actions.FIGHT, actor, target)
		options.hide()
		enemies.release()
		await(event_queue.run())
		current_player_index = 0
	
	action = -1
	options.button_focus()
	
func _on_options_button_pressed(button: BaseButton, _index: int) -> void:
	match button.text:
		"Fight":
			action = Actions.FIGHT
			enemies.button_focus()
		"Mask":
			$MarginContainer/MaskMenu.show()
		_:
			pass


func _on_enemies_button_pressed(button: BaseButton, _index: int) -> void:
	#send action to event queue
	var actor: BattleActor = party[current_player_index]
	var target: BattleActor = button.data
	event_queue.add(action, actor, target)
	goto_next_player()
	
