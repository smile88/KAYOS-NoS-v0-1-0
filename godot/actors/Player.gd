extends CharacterBody2D
## Top-down 4-direction player (GDD §13: Player is its own scene, instanced into zones).
## Placeholder 32x48 body until CH-001 sprites are cleaned; `facing` is tracked now so the
## AnimatedSprite2D swap-in is trivial later.

@export var speed: float = 90.0

var facing: Vector2 = Vector2.DOWN

@onready var interactor: Area2D = $Interactor


func _physics_process(_delta: float) -> void:
	# Freeze during dialogue so movement doesn't fight the conversation.
	if DialogueManager.is_active():
		velocity = Vector2.ZERO
		return
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = dir * speed
	if dir != Vector2.ZERO:
		facing = dir.normalized()
	move_and_slide()


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
