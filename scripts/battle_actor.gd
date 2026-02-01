class_name BattleActor extends Resource

@export var name: String = ""
@export var hp_max: int = 1
@export var mp_max: int = 0

var hp: int = hp_max
var mp: int = mp_max

func init() -> void:
	hp = hp_max
	mp = mp_max

func copy() -> BattleActor:
	var dup: BattleActor = duplicate()
	dup.init()
	return dup
