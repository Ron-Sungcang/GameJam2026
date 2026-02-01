class_name PlayerWindow extends Button

@onready var player_name: Label = $PanelContainer/VBoxContainer/PlayerName
@onready var hp_2: Label = $PanelContainer/VBoxContainer/HP/HP2
@onready var mp_2: Label = $PanelContainer/VBoxContainer/MP/MP2
@onready var damage: int = 20


var data: BattleActor = null:
	set(value):
		data = value
		
		if data:
			if data.is_connected("hp_changed", _on_data_hp_changed):
				data.hp_changed.disconnect(_on_data_hp_changed)
			data = data.copy()
			data.hp_changed.connect(_on_data_hp_changed)
			player_name.text = data.name
			hp_2.text = str(data.hp)
			mp_2.text = str(data.mp)
			show()
		else:
			hide()
		visible = data != null

func _on_data_hp_changed(hp: int, _hp_max: int, _value_changed: int) -> void:
	self.hp_2.text = str(hp)
	
