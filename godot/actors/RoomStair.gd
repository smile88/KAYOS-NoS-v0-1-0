extends Interactable
class_name RoomStair
## A stair between two rooms of a single-scene zone (the Cold Open's balcony and the scriptorium
## below it). The zone's director owns the actual move — camera limits, player placement, the fade —
## because it also owns the clock and needs to know which room the player is standing in. The stair
## just announces that it was used.

signal used(stair: RoomStair)

## Key into the director's ROOMS table, e.g. "scriptorium".
@export var target_room: String = ""


func interact() -> void:
	used.emit(self)
