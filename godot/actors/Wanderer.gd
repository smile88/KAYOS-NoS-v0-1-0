@tool
extends NPC
class_name Wanderer
## An NPC with somewhere to be. Drifts around `roam_rect`, pausing, so a public space reads as
## populated rather than staged. Deliberately dumb — no pathing, no collision avoidance; it exists
## to make a crowd feel alive at a distance, not to be clever up close.
##
## Freezes while a conversation is open (nobody wanders off mid-sentence) and when the director
## calls freeze() — at the Silence the whole crowd stops at once, which is the entire point of
## having a crowd.

## Area this NPC keeps to, in the zone's coordinates. Zero size = stand still.
@export var roam_rect: Rect2 = Rect2()
@export var speed: float = 22.0
@export var pause_min: float = 1.2
@export var pause_max: float = 5.0

var _target := Vector2.ZERO
var _pause_left := 0.0
var _frozen := false


func _ready() -> void:
	super._ready()
	if Engine.is_editor_hint():
		return
	add_to_group("wanderer")
	_target = global_position
	_pause_left = randf_range(0.0, pause_max)


func _process(delta: float) -> void:
	if Engine.is_editor_hint() or _frozen or roam_rect.size == Vector2.ZERO:
		return
	if DialogueManager.is_active():
		return

	if _pause_left > 0.0:
		_pause_left -= delta
		if _pause_left <= 0.0:
			_target = Vector2(
				randf_range(roam_rect.position.x, roam_rect.end.x),
				randf_range(roam_rect.position.y, roam_rect.end.y))
		return

	var to := _target - global_position
	if to.length() <= 3.0:
		_pause_left = randf_range(pause_min, pause_max)
		return
	global_position += to.normalized() * speed * delta


## Stop where you are. The director uses this the moment the Song stops.
func freeze() -> void:
	_frozen = true


## Everyone turns and moves to the rail to look. No pathing, no ceremony — they just go. Spread wide
## along the rail rather than converging on one point, so it reads as a crowd lining the balustrade
## instead of a scrum around a dropped coin.
func rush_to(point: Vector2, over: float) -> void:
	_frozen = true
	var tw := create_tween()
	tw.tween_property(self, "global_position",
		Vector2(clampf(point.x + randf_range(-460, 460), 60, 1220), point.y + randf_range(0, 40)),
		over).set_trans(Tween.TRANS_SINE)
