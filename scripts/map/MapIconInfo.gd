extends Resource
class_name MapIconInfo

enum Type { ELITE, COMMON, REST, BOSS, NOT_ASSIGNED }

@export
var type: Type
@export
var sprite: Texture2D
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
