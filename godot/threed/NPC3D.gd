@tool
extends Interactable3D
class_name NPC3D
## A 3D-model NPC for the Cold Open — a hooded figure (CharacterModel3D) that the player can examine
## (its examine_text is its passing characterisation, §8.4). Whoever moves it calls
## walk_toward(world_dir) / stop_walking(); unlike the old billboard it simply **turns to face its
## heading** and reads correctly from any orbit angle — no sprite rows, no quantised diagonal.

## The robe colour distinguishes one figure from another (the crowd used to share one silhouette).
@export var robe_color := Color(0.40, 0.34, 0.28)

var model: CharacterModel3D


func _ready() -> void:
	super._ready()   # Interactable3D: joins group "interactable3d"
	# A script hot-reload while the scene is open can re-fire _ready() on the same node without a
	# fresh scene load — drop any previous preview model first so it doesn't double up.
	var old := get_node_or_null("CharacterModel")
	if old:
		old.queue_free()
	model = CharacterModel3D.new()
	model.name = "CharacterModel"
	model.robe_color = robe_color
	add_child(model)


## Face and animate along a world-space ground direction.
func walk_toward(world_dir: Vector3) -> void:
	if model:
		model.face_dir(world_dir)
		model.set_moving(true)


func stop_walking() -> void:
	if model:
		model.set_moving(false)
