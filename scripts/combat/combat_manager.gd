extends Node

enum CombatState{
	START_COMBAT,
	TURN_ORDER,
	ENEMY_INPUTS,
	PLAYER_INPUTS,
	ACTION,
	END_TURN
}

var curr_state: CombatState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enter_combat()

# Probably wont need process here
#func _process(delta: float) -> void:
#	pass

func change_state(new_state: CombatState) -> void:
	curr_state = new_state
	execute_state()

func execute_state() -> void:
	match curr_state:
		CombatState.START_COMBAT:
			start_combat()
		CombatState.TURN_ORDER:
			turn_order()
		CombatState.ENEMY_INPUTS:
			enemy_inputs()
		CombatState.PLAYER_INPUTS:
			player_inputs()
		CombatState.ACTION:
			action()
		CombatState.END_TURN:
			end_turn()

func enter_combat() -> void:
	print("Entering combat")
	
	#TODO: Actions when entering combat, such as getting units involved in combat
	
	change_state(CombatState.START_COMBAT)

#TODO: Actions during start combat, includes things like a "Start Combat" alert
func start_combat() -> void:
	return
	
#TODO: Set the turn order of unit actions before the start of turn
func turn_order() -> void:
	return

#TODO: Actions of enemy ai
func enemy_inputs() -> void:
	return

#TODO: Actions of player
func player_inputs() -> void:
	return

#TODO: Complete the actions selected by both Player and Enemy
func action() -> void:
	return
	
#TODO: End turn, prepare for the start of next turn
func end_turn() -> void:
	return
