@tool
extends Interactable3D
class_name NPC3D
## A 3D-model NPC for KAYOS: The Night of Silence (Starfall & the Cold Open).
## Uses CharacterModel3D for low-poly robed figure rendering with racial color palettes,
## scale variations, world-space nameplate, and interaction prompt indicators.
##
## Drop into a 3D scene, assign a CharacterData or configure race/colors in the Inspector.

@export var character_data: CharacterData : set = _set_character_data
@export var race: CharacterModel3D.Race = CharacterModel3D.Race.CUSTOM : set = _set_race
@export var robe_color := Color(0, 0, 0, 0) : set = _set_robe_color
@export var show_label := true : set = _set_show_label
@export var show_prompt := true : set = _set_show_prompt
@export var prompt_text := "[E] Talk" : set = _set_prompt_text

var model: CharacterModel3D
var _label_anchor: Node3D
var _name_label: Label3D
var _prompt_label: Label3D


func _ready() -> void:
	super._ready()   # Interactable3D: joins group "interactable3d"
	_setup_model()
	if character_data:
		_apply_character_data()
	elif race != CharacterModel3D.Race.CUSTOM:
		_apply_race()
	elif robe_color.a > 0.0 and model:
		model.robe_color = robe_color
	_setup_labels()
	_update_labels()


func _setup_model() -> void:
	var old := get_node_or_null("CharacterModel")
	if old:
		old.queue_free()
	model = CharacterModel3D.new()
	model.name = "CharacterModel"
	if race != CharacterModel3D.Race.CUSTOM:
		model.race = race
	elif robe_color.a > 0.0:
		model.robe_color = robe_color
	add_child(model)


func _setup_labels() -> void:
	var old := get_node_or_null("LabelAnchor")
	if old:
		old.queue_free()

	_label_anchor = Node3D.new()
	_label_anchor.name = "LabelAnchor"
	var height := 2.15
	if model:
		height = 2.15 * model.character_scale.y
	_label_anchor.position = Vector3(0, height, 0)
	add_child(_label_anchor)

	_name_label = Label3D.new()
	_name_label.name = "NameLabel"
	_name_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	_name_label.font_size = 28
	_name_label.outline_size = 8
	_name_label.outline_modulate = Color(0.05, 0.05, 0.08, 0.95)
	_name_label.modulate = Color(0.96, 0.96, 1.0)
	_name_label.no_depth_test = false
	_label_anchor.add_child(_name_label)

	_prompt_label = Label3D.new()
	_prompt_label.name = "PromptLabel"
	_prompt_label.position = Vector3(0, -0.28, 0)
	_prompt_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	_prompt_label.font_size = 18
	_prompt_label.outline_size = 6
	_prompt_label.outline_modulate = Color(0.05, 0.05, 0.08, 0.95)
	_prompt_label.modulate = Color(0.95, 0.85, 0.45)   # Warm soft gold
	_prompt_label.no_depth_test = false
	_label_anchor.add_child(_prompt_label)


func _set_character_data(value: CharacterData) -> void:
	character_data = value
	if is_inside_tree():
		_apply_character_data()
		_update_labels()


func _apply_character_data() -> void:
	if not character_data:
		return
	if display_name == "" or Engine.is_editor_hint():
		display_name = character_data.display_name
	if dialogue == "" and character_data.default_dialogue != "":
		dialogue = character_data.default_dialogue
	if portrait_id == "" and character_data.id != "":
		portrait_id = character_data.id
	if examine_text == "" and character_data.editor_notes != "":
		examine_text = character_data.editor_notes
	if model:
		model.apply_faction(character_data.faction)
		if robe_color.a > 0.0:
			model.robe_color = robe_color
		if _label_anchor:
			_label_anchor.position.y = 2.15 * model.character_scale.y


func _set_race(value: CharacterModel3D.Race) -> void:
	race = value
	if model:
		model.race = race
	if _label_anchor and model:
		_label_anchor.position.y = 2.15 * model.character_scale.y


func _apply_race() -> void:
	if model and race != CharacterModel3D.Race.CUSTOM:
		model.race = race
		if _label_anchor:
			_label_anchor.position.y = 2.15 * model.character_scale.y


func _set_robe_color(value: Color) -> void:
	robe_color = value
	if model and robe_color.a > 0.0:
		model.robe_color = robe_color


func _set_show_label(value: bool) -> void:
	show_label = value
	if _name_label:
		_name_label.visible = show_label


func _set_show_prompt(value: bool) -> void:
	show_prompt = value
	if _prompt_label:
		_prompt_label.visible = show_prompt


func _set_prompt_text(value: String) -> void:
	prompt_text = value
	if _prompt_label:
		_prompt_label.text = prompt_text


func _update_labels() -> void:
	if _name_label:
		var txt := display_name
		if txt == "" and character_data:
			txt = character_data.display_name
		_name_label.text = txt
		_name_label.visible = show_label and (txt != "")
	if _prompt_label:
		_prompt_label.text = prompt_text
		_prompt_label.visible = show_prompt and (_name_label != null and _name_label.visible)


## Face and animate along a world-space ground direction.
func walk_toward(world_dir: Vector3) -> void:
	if model:
		model.face_dir(world_dir)
		model.set_moving(true)


func stop_walking() -> void:
	if model:
		model.set_moving(false)


func face(world_dir: Vector3) -> void:
	if model:
		model.face_dir(world_dir)
