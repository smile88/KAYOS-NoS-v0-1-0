extends CharacterBody2D
## Top-down 4-direction player (GDD §13: Player is its own scene, instanced into zones).
## Body is CH-001 (48x72 frames, 4x4 sheet, rows = down/up/right/left — GDD §13).

@export var speed: float = 90.0

## Per-zone character override. The Player scene bakes CH-001 (Elorin); set this in a zone that
## stars someone else — the Cold Open sets Talindir's sheet here — and the frames are rebuilt from
## it at load via SpriteSheet. Leave empty to keep the baked Elorin frames.
@export var sheet_override: Texture2D

## --- Step bob (temporary; see the note) --------------------------------------
## The CH-001 walk rows aren't a walk cycle: measured across the four frames of each row, the boots
## shift by 1px (down) to 3px (sides). The generator produced near-identical standing poses, so the
## legs never alternate and she reads as gliding. Until the legs are hand-animated in Affinity, a
## small synced bob does the work the frames aren't doing — it's what the eye reads as footfalls.
##
## **Delete this whole block once real leg animation lands.** It is compensation for missing art,
## not a style. Set `step_bob_px = 0.0` to switch it off and judge the raw sheet.
@export var step_bob_px: float = 1.5      ## vertical rise per step, in world px
@export var step_lean_deg: float = 1.2    ## slight tilt into the direction of travel
@export var step_hz: float = 4.0          ## footfalls per second at full speed

var facing: Vector2 = Vector2.DOWN

@onready var interactor: Area2D = $Interactor
@onready var body: AnimatedSprite2D = $Body

var _body_rest_y: float = 0.0
var _bob_phase: float = 0.0


func _ready() -> void:
	if sheet_override:
		body.sprite_frames = SpriteSheet.frames_from(sheet_override)
		body.animation = "walk_down"
	_body_rest_y = body.position.y


func _physics_process(delta: float) -> void:
	# Freeze during dialogue so movement doesn't fight the conversation.
	if DialogueManager.is_active():
		velocity = Vector2.ZERO
		_update_animation(Vector2.ZERO)
		_update_step_bob(Vector2.ZERO, delta)
		return
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = dir * speed
	if dir != Vector2.ZERO:
		facing = dir.normalized()
	move_and_slide()
	_update_animation(d	ir)
	_update_step_bob(dir, delta)


func _update_animation(dir: Vector2) -> void:
	var anim := "walk_" + _facing_name()
	if dir == Vector2.ZERO:
		if body.is_playing():
			body.stop()
		body.animation = anim
		body.frame = 0
		return
	if body.animation != anim or not body.is_playing():
		body.play(anim)


## Two footfalls per stride, so the bob runs at 2x the step rate and never rises below the rest
## position — she pushes *up* off the ground rather than sinking into it.
func _update_step_bob(dir: Vector2, delta: float) -> void:
	if step_bob_px <= 0.0:
		return
	if dir == Vector2.ZERO:
		_bob_phase = 0.0
		body.position.y = move_toward(body.position.y, _body_rest_y, 24.0 * delta)
		body.rotation_degrees = move_toward(body.rotation_degrees, 0.0, 90.0 * delta)
		return
	_bob_phase = fmod(_bob_phase + delta * step_hz * TAU, TAU)
	body.position.y = _body_rest_y - absf(sin(_bob_phase)) * step_bob_px
	# Lean only on the side views; a top-down front/back lean just looks like falling over.
	var lean := 0.0
	if absf(facing.x) > absf(facing.y):
		lean = signf(facing.x) * step_lean_deg * sin(_bob_phase * 0.5)
	body.rotation_degrees = lean

func _facing_name() -> String:
	if absf(facing.x) > absf(facing.y):
		return "right" if facing.x > 0.0 else "left"
	return "down" if facing.y > 0.0 else "up"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not DialogueManager.is_active():
		_try_interact()

func _try_interact() -> void:
	var nearest: Interactable = null
	var best := INF
	for a in interactor.get_overlapping_areas():
		if a is Interactable:
			var d := global_position.distance_to((a as Node2D).global_position)
			if d < best:
				best = d
				nearest = a
	if nearest:
		nearest.interact()
