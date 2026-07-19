extends Node3D
class_name RoomCoordinator3D
## Owns the mechanical half of a room change in the single-scene 3D Cold Open: when a RoomStair3D is
## used, it fades, sets the player down at the target room's spawn, and retargets the camera (moving
## its floor guard to the new room's floor so the rig doesn't clamp above the scriptorium 40 m down).
##
## This is the "reposition the player + retarget the rig on stair use" the pivot plan assigns to the
## director — split out so it is testable now (step F), before the clock exists. The ColdOpen3D
## director (step G) drives the SAME move by awaiting go_to_room(); it layers the narrative on top
## (pause the festival clock while the change runs, speak the first-descent / first-ascent line) by
## connecting to `room_changed` and calling go_to_room() itself instead of letting stairs auto-fire —
## set `auto` = false for that.

signal room_changed(room_name: String)

@export var player_path: NodePath
@export var rig_path: NodePath
## The Scriptorium3D node; its world transform + Scriptorium3D.SPAWN gives the descent landing spot.
@export var scriptorium_path: NodePath
## Where the player stands on the balcony after climbing back up (world space).
@export var balcony_spawn := Vector3(-6.0, 0.0, 2.6)
## When true (step F demo), using a stair moves rooms directly. The director sets it false and drives
## the move itself so it can pause the clock and speak first.
@export var auto := true

const FADE_TIME := 0.26

var current_room := "balcony"
var _busy := false
var _rooms := {}
var _fade: ColorRect


func _ready() -> void:
	var scr := get_node_or_null(scriptorium_path) as Node3D
	_rooms = {
		"balcony": { "spawn": balcony_spawn, "floor_y": 0.0 },
	}
	if scr:
		_rooms["scriptorium"] = {
			"spawn": scr.global_position + Scriptorium3D.SPAWN,
			"floor_y": scr.global_position.y,
		}

	_build_fade()
	# Let the rooms build their stairs (children ready before us, but sibling order is not guaranteed)
	# before we connect them.
	await get_tree().process_frame
	for node in get_tree().get_nodes_in_group("room_stair"):
		var stair := node as RoomStair3D
		if stair and not stair.used.is_connected(_on_stair_used):
			stair.used.connect(_on_stair_used)


func _build_fade() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 90                      # under the DialogueUI, over the world
	add_child(layer)
	_fade = ColorRect.new()
	_fade.color = Color(0, 0, 0, 0)
	_fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(_fade)


func _on_stair_used(stair: RoomStair3D) -> void:
	if auto:
		await go_to_room(stair.target_room)


## Fade out, move the player into `name` and retarget the camera to that room's floor, fade back.
## Safe to await. No-op on an unknown room or while another change runs.
func go_to_room(name: String) -> void:
	if _busy or name == current_room or not _rooms.has(name):
		return
	_busy = true

	await _fade_to(1.0)

	var player := get_node_or_null(player_path) as Node3D
	var rig := get_node_or_null(rig_path) as CameraRig3D
	var room: Dictionary = _rooms[name]
	if player:
		player.global_position = room["spawn"]
	if rig:
		rig.floor_min_y = float(room["floor_y"]) + 0.3
		rig._place()                       # snap, don't swoop across the 40 m between rooms
	current_room = name

	# One frame so the camera settles on the new room before we show it.
	await get_tree().process_frame
	await _fade_to(0.0)

	_busy = false
	room_changed.emit(name)


func _fade_to(a: float) -> void:
	if _fade == null:
		return
	var tw := create_tween()
	tw.tween_property(_fade, "color:a", a, FADE_TIME)
	await tw.finished
