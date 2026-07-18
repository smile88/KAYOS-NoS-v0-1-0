extends CharacterBody3D
class_name Player3D
## HD-2D player for the 3D Cold Open: a CharacterBody3D that slides around the XZ ground plane while
## its body is the existing 2D walk sheet standing up as an AnimatedSprite3D billboard (Octopath
## look). Movement is camera-relative — WASD pushes along the orbiting camera's ground axes — and the
## walk row (down/up/right/left) is chosen by projecting motion onto the camera basis, so the sprite's
## visible facing stays correct at any orbit angle. Same SpriteSheet slicing the 2D game uses.

@export var speed := 4.0
## The character sheet to wear. The Cold Open dresses the player as Talindir; leave empty and the
## billboard just won't have frames (the test scene sets it).
@export var sheet: Texture2D
## 48×72 sprite at this pixel_size → ~2.1 m tall standing on the floor. See sprite_sheet.gd.
@export var pixel_size := 0.03

var facing := "down"

@onready var body: AnimatedSprite3D = $Body

var _rig: CameraRig3D


func _ready() -> void:
	if sheet:
		body.sprite_frames = SpriteSheet.frames_from(sheet)
	body.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	body.shaded = false
	body.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	body.alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	body.pixel_size = pixel_size
	# Feet on the floor: the CharacterBody3D origin sits at ground level, so lift the sprite so its
	# bottom edge (72 px * pixel_size tall) rests at y = 0.
	body.position.y = (72.0 * pixel_size) * 0.5
	body.animation = "walk_down"
	body.stop()


func _physics_process(_delta: float) -> void:
	if _rig == null:
		_rig = get_tree().get_first_node_in_group("camera_rig") as CameraRig3D

	if DialogueManager.is_active():
		velocity = Vector3.ZERO
		_animate(Vector3.ZERO)
		return

	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var move := Vector3.ZERO
	if _rig and input != Vector2.ZERO:
		# input.y is +1 when pressing "down" (toward the player on screen), so move along -forward.
		move = _rig.right_xz() * input.x - _rig.forward_xz() * input.y
		move = move.normalized()

	velocity = move * speed
	move_and_slide()
	_animate(move)


## Pick the walk row by comparing motion against the camera's ground axes, then play/stop the sprite.
func _animate(move: Vector3) -> void:
	if move == Vector3.ZERO:
		if body.is_playing():
			body.stop()
		return
	if _rig:
		var fwd := _rig.forward_xz()
		var rgt := _rig.right_xz()
		var f := move.dot(fwd)      # +: away from camera (up row);  -: toward camera (down row)
		var r := move.dot(rgt)      # +: screen-right;               -: screen-left
		if absf(f) >= absf(r):
			facing = "up" if f > 0.0 else "down"
		else:
			facing = "right" if r > 0.0 else "left"
	var anim := "walk_" + facing
	if body.animation != anim or not body.is_playing():
		body.play(anim)
