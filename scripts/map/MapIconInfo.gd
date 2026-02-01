extends Resource
class_name MapIconInfo

enum Type { NOT_ASSIGNED ,ELITE, COMMON, REST, BOSS }

@export
var type: Type
@export
var selected := false
@export
var row: int
@export
var column: int
@export
var position: Vector2
@export
var next_icons: Array[MapIconInfo]
