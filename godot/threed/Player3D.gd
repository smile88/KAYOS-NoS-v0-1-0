extends CharacterBody3D
class_name Player3D
## 3D-model player for the Cold Open: a CharacterBody3D whose body is a CharacterModel3D (a low-poly
## hooded figure) that turns to face its movement direction. Movement is camera-relative — WASD pushes
## along the orbiting camera's ground axes — and the model simply rotates to its heading, so there is
## no billboard-facing-camera and no quantised diagonal walk. In first person the model is hidden
## (you're inside it).

@export var speed := 4.0
## How close (world m, on the ground plane) the player must be to examine an Interactable3D.
@export var interact_reach := 1.8
## Robe colour of the player figure. The Cold Open dresses Talindir in a cool grey-blue.
@export var robe_color := Color(0.36, 0.40, 0.52)
## Off = the Cold Open's flat-plane movement (Y never changes). On = a real terraced world: the body
## falls, stands on floors and walks up/down ramps (Starfall). Kept opt-in so the Cold Open is unchanged.
@export var gravity_enabled := false
@export var gravity := 26.0
## Upward launch speed for a jump (only when gravity_enabled). ~1.2 m hop at the default gravity.
@export var jump_velocity := 8.0
## Hold to move faster — handy for crossing a large zone. Uses the "run" action if present, else Shift.
@export var run_multiplier := 1.9

var model: CharacterModel3D
var _rig: CameraRig3D


func _ready() -> void:
	model = CharacterModel3D.new()
	model.name = "Model"
	model.robe_color = robe_color
	add_child(model)
	if gravity_enabled:
		floor_snap_length = 0.6          # stay glued descending ramps/steps
		floor_max_angle = deg_to_rad(50) # our terrace ramps sit well under this


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not DialogueManager.is_active():
		_try_interact()


## Examine the nearest Interactable3D within reach (ground-plane distance) — a group scan, plenty for
## the handful of props on the balcony.
func _try_interact() -> void:
	var nearest: Interactable3D = null
	var best := interact_reach
	var here := global_position
	for node in get_tree().get_nodes_in_group("interactable3d"):
		var it := node as Interactable3D
		if it == null:
			continue
		var d := Vector2(it.global_position.x - here.x, it.global_position.z - here.z).length()
		if d <= best:
			best = d
			nearest = it
	if nearest:
		nearest.interact()


func _physics_process(_delta: float) -> void:
	if _rig == null:
		_rig = get_tree().get_first_node_in_group("camera_rig") as CameraRig3D

	# In first person you're inside your own body — hide the model so it doesn't fill the view.
	if _rig:
		model.visible = not _rig.is_first_person()

	if DialogueManager.is_active():
		velocity.x = 0.0
		velocity.z = 0.0
		if gravity_enabled and not is_on_floor():
			velocity.y -= gravity * _delta
		model.set_moving(false)
		move_and_slide()
		return

	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move := Vector3.ZERO
	if _rig and input != Vector2.ZERO:
		# input.y is +1 when pressing "down" (toward the player on screen), so move along -forward.
		move = _rig.right_xz() * input.x - _rig.forward_xz() * input.y
		move = move.normalized()

	if gravity_enabled:
		# Real world: keep vertical velocity for gravity, drive only the ground plane from input.
		var spd := speed
		if Input.is_key_pressed(KEY_SHIFT) or (InputMap.has_action("run") and Input.is_action_pressed("run")):
			spd *= run_multiplier
		velocity.x = move.x * spd
		velocity.z = move.z * spd
		if is_on_floor():
			if InputMap.has_action("jump") and Input.is_action_just_pressed("jump"):
				velocity.y = jump_velocity
			else:
				velocity.y = -1.0        # small downward bias so floor snapping holds
		else:
			velocity.y -= gravity * _delta
	else:
		velocity = move * speed          # Cold Open: flat-plane movement, no gravity
	move_and_slide()

	if move != Vector3.ZERO:
		model.face_dir(move)
		model.set_moving(true)
	else:
		model.set_moving(false)
