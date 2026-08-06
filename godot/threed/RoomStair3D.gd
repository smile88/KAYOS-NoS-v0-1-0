@tool
extends Interactable3D
class_name RoomStair3D
## A stair between two rooms of the single-scene 3D Cold Open — the HD-2D twin of actors/RoomStair.gd.
## Like the 2D one it does NOT own the move: whoever owns the clock (the RoomCoordinator3D now, the
## ColdOpen3D director in step G) needs to know which room the player is standing in, so the stair
## just announces that it was used and lets that owner reposition the player and retarget the camera.
## It still lives in group "interactable3d" (parent _ready) so the player examines it like anything
## else, and in group "room_stair" so the coordinator can find and connect it.

signal used(stair: RoomStair3D)

## Key into the coordinator's rooms table, e.g. "scriptorium".
@export var target_room: String = ""


func _ready() -> void:
	super._ready()
	add_to_group("room_stair")


## Unlike a plain Interactable3D, using a stair emits `used` rather than showing examine text — the
## coordinator does the rest (same contract as RoomStair.interact() in 2D).
func interact() -> void:
	used.emit(self)
