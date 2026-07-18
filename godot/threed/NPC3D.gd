extends Interactable3D
class_name NPC3D
## A billboard NPC for the 3D Cold Open — HD-2D twin of actors/NPC.gd. Extends Interactable3D so the
## player can examine it (its examine_text is its passing characterisation, §8.4), and adds an
## animated walk-sheet billboard driven the same camera-relative way the player is: whoever moves it
## calls walk_toward(world_dir) / stop_walking(), and the visible walk row (down/up/left/right) is
## chosen by projecting that direction onto the orbiting camera's axes, so facings stay correct at
## any orbit angle.

@export var sheet: Texture2D
@export var pixel_size := 0.03

var body: AnimatedSprite3D
var _facing := "down"
var _moving := false
var _rig: CameraRig3D


func _ready() -> void:
	super._ready()   # Interactable3D: joins group "interactable3d"; no prop (prop_texture empty)
	body = AnimatedSprite3D.new()
	body.name = "Body"
	if sheet:
		body.sprite_frames = SpriteSheet.frames_from(sheet)
	body.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	body.shaded = false
	body.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	body.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	body.pixel_size = pixel_size
	body.position.y = (72.0 * pixel_size) * 0.5
	body.animation = "walk_down"
	body.stop()
	add_child(body)


func _get_rig() -> CameraRig3D:
	if _rig == null:
		_rig = get_tree().get_first_node_in_group("camera_rig") as CameraRig3D
	return _rig


## Walk-row selection, shared with the player's: project the world move onto the camera's ground
## axes and let the larger component pick the axis. Returns "up"/"down"/"left"/"right".
func row_for(move: Vector3) -> String:
	var rig := _get_rig()
	if rig == null or move == Vector3.ZERO:
		return _facing
	var f := move.dot(rig.forward_xz())
	var r := move.dot(rig.right_xz())
	if absf(f) >= absf(r):
		return "up" if f > 0.0 else "down"
	return "right" if r > 0.0 else "left"


## Move-driven animation: face along `world_dir` (relative to the camera) and play the walk cycle.
func walk_toward(world_dir: Vector3) -> void:
	_facing = row_for(world_dir)
	_moving = true
	_refresh_anim()


func stop_walking() -> void:
	_moving = false
	_refresh_anim()


func _refresh_anim() -> void:
	if body == null or body.sprite_frames == null:
		return
	var anim := "walk_" + _facing
	if not body.sprite_frames.has_animation(anim):
		return
	if body.animation != anim:
		body.animation = anim
	if _moving:
		if not body.is_playing():
			body.play(anim)
	else:
		body.stop()
		body.frame = 0
