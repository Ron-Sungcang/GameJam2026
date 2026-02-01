class_name PlayerWindow extends Button

@onready var player_name: Label = $PanelContainer/VBoxContainer/PlayerName
@onready var hp_2: Label = $PanelContainer/VBoxContainer/HP/HP2
@onready var mp_2: Label = $PanelContainer/VBoxContainer/MP/MP2


var data: BattleActor = null:
	set(value):
		data = value.copy()
		
		if data:
			data = data.copy()
			player_name.text = data.name
			hp_2.text = str(data.hp)
			mp_2.text = str(data.mp)
			show()
		else:
			hide()
		visible = data != null
