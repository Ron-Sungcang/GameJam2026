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

@export var ui: combat_ui
@export var player_position: HBoxContainer
@export var enemy_positions: HBoxContainer

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
	UnitManagerTestScene.load_enemy_res()
	
	ui.disable_user_ui()
	ui.set_button_action(complete_player_action)
	
	set_enemy_starting_position()
	
	print("Entering combat")
	
	#TODO: Actions when entering combat, getting stage info such as units involved in combat
	
	change_state(CombatState.START_COMBAT)

func set_enemy_starting_position() -> void:
	if UnitManagerTestScene.enemy_units == null:
		print("UnitManager has an empty array of enemy units")
		return
		
	for enemy in UnitManagerTestScene.enemy_units:
		enemy.unit_sprite.reparent(enemy_positions, false)

func complete_player_action() -> void:
	if(curr_state != CombatState.PLAYER_INPUTS):
		print("Not in player input state")
		return
	
	print("Player inputs complete")
	change_state(CombatState.ACTION)

#TODO: Actions during start combat, includes things like a "Start Combat" alert
func start_combat() -> void:
	
	change_state(CombatState.TURN_ORDER)
	
#TODO: Set the turn order of unit actions before the start of turn
func turn_order() -> void:
	print("Turn order")
	change_state(CombatState.ENEMY_INPUTS)
	#return

#TODO: Actions of enemy ai
func enemy_inputs() -> void:
	print("Enemy Input")
	change_state(CombatState.PLAYER_INPUTS)
	#return

#TODO: Actions of player
func player_inputs() -> void:
	print("Player Input")
	ui.enable_user_ui()

#TODO: Complete the actions selected by both Player and Enemy
func action() -> void:
	print("Action state")
	
	#Disable UI before comitting actions
	ui.disable_user_ui()
	#TODO: Complete unit actions
	
	change_state(CombatState.END_TURN)
	
#TODO: End turn, prepare for the start of next turn
func end_turn() -> void:
	print("Turn completed")
	#TODO: Do actions related to a turn ending, before starting a new turn order
	
	change_state(CombatState.TURN_ORDER)
