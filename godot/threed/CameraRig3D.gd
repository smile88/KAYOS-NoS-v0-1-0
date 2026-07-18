extends Camera3D
class_name CameraRig3D
## Orbiting isometric-ish third-person camera for the HD-2D Cold Open. Follows a target on the
## ground and swings 360° around it. Right-mouse drag orbits (and tilts a little); the mouse wheel
## zooms; Q/E orbit from the keyboard. Sits in group "camera_rig" so the player can read its facing
## for camera-relative movement.

@export var target_path: NodePath
@export var distance := 11.0
@export var min_distance := 5.0
@export var max_distance := 20.0
@export var pitch_deg := 48.0            # elevation above the target; ~iso feel
@export var height := 1.4                # look at roughly chest height
@export var follow_lerp := 8.0
@export var key_orbit_speed := 1.6       # rad/s for Q/E
@export var drag_sensitivity := 0.008

var yaw := 0.0
var _target: Node3D


func _ready() -> void:
	add_to_group("camera_rig")
	_target = get_node_or_null(target_path) as Node3D
	if _target:
		global_position = _desired_position(_target.global_position)
		_aim()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		yaw -= event.relative.x * drag_sensitivity
		pitch_deg = clampf(pitch_deg + event.relative.y * drag_sensitivity * 40.0, 20.0, 75.0)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			distance = clampf(distance - 1.0, min_distance, max_distance)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			distance = clampf(distance + 1.0, min_distance, max_distance)


func _process(delta: float) -> void:
	if _target == null:
		return
	if Input.is_action_pressed("cam_left"):
		yaw += key_orbit_speed * delta
	if Input.is_action_pressed("cam_right"):
		yaw -= key_orbit_speed * delta
	var want := _desired_position(_target.global_position)
	global_position = global_position.lerp(want, clampf(follow_lerp * delta, 0.0, 1.0))
	_aim()


func _desired_position(target_pos: Vector3) -> Vector3:
	var p := deg_to_rad(pitch_deg)
	var offset := Vector3(cos(p) * sin(yaw), sin(p), cos(p) * cos(yaw)) * distance
	return target_pos + Vector3.UP * height + offset


func _aim() -> void:
	if _target:
		look_at(_target.global_position + Vector3.UP * height, Vector3.UP)


## Ground-plane forward (into the screen, away from the camera) — the player moves relative to this.
func forward_xz() -> Vector3:
	if _target == null:
		return Vector3.FORWARD
	var f := (_target.global_position - global_position)
	f.y = 0.0
	return f.normalized()


func right_xz() -> Vector3:
	var f := forward_xz()
	return Vector3(f.z, 0.0, -f.x)   # f rotated -90° about Y
