extends Control
## Character Creation (GDD §2.4 / §7.1 / §7.4 / §7.5) — the game's actual first scene.
## A 4-step wizard: attribute point-buy, class pick, background perk pick, summary/confirm.
## Writes P1_CLASS / P1_PERK and the seven attributes to GameState, then hands off to the
## next playable scene. Placeholder styling only — UI-007 (illuminated character sheet) drops
## in during Phase 3 art; class/perk content is data-driven from data/character_creation.json.

const DATA_PATH := "res://data/character_creation.json"
## Cold Open (Phase 2.5) isn't built yet — hand off straight to the Starfall slice for now.
const NEXT_SCENE := "res://scenes/zones/StarfallAcademy.tscn"

const COL_NORMAL := Color(0.90, 0.88, 0.98)
const COL_GOLD := Color(0.95, 0.82, 0.42)
const COL_DIM := Color(0.55, 0.56, 0.66)
const COL_SELECTED := Color(0.62, 0.85, 0.70)

const STEP_NAMES := ["Attributes", "Class", "Background", "Summary"]

@onready var step_label: Label = %StepLabel
@onready var step_host: ScrollContainer = %StepHost
@onready var points_label: Label = %PointsLabel
@onready var back_button: Button = %BackButton
@onready var next_button: Button = %NextButton

var _data: Dictionary = {}
var _attr_values: Dictionary = {}
var _selected_class: String = ""
var _selected_perk: String = ""
var _step: int = 0


func _ready() -> void:
	_data = _load_data()
	var base: int = int(_data.get("base_value", 3))
	for attr in _data.get("attributes", []):
		_attr_values[attr] = base
	back_button.pressed.connect(_on_back)
	next_button.pressed.connect(_on_next)
	_render_step()


func _load_data() -> Dictionary:
	var f := FileAccess.open(DATA_PATH, FileAccess.READ)
	if not f:
		push_error("CharacterCreation: could not open %s" % DATA_PATH)
		return {}
	var parsed = JSON.parse_string(f.get_as_text())
	f.close()
	return parsed if typeof(parsed) == TYPE_DICTIONARY else {}


## --- step scaffolding ---------------------------------------------------------
func _clear_host() -> void:
	for c in step_host.get_children():
		c.queue_free()


func _render_step() -> void:
	step_label.text = "Step %d of %d — %s" % [_step + 1, STEP_NAMES.size(), STEP_NAMES[_step]]
	back_button.disabled = _step == 0
	next_button.text = "Begin ▸" if _step == STEP_NAMES.size() - 1 else "Next ▸"
	match _step:
		0: _render_attributes()
		1: _render_class()
		2: _render_perk()
		_: _render_summary()
	_refresh_next_enabled()


## --- step 0: attribute point-buy (GDD §7.1: pool 30, base 3, min 1 / max 8) ---
func _points_remaining() -> int:
	var spent := 0
	for v in _attr_values.values():
		spent += int(v)
	return int(_data.get("point_pool", 30)) - spent


func _render_attributes() -> void:
	_clear_host()
	points_label.show()

	var grid := GridContainer.new()
	grid.columns = 4
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 4)
	step_host.add_child(grid)

	for attr in _data.get("attributes", []):
		var name_label := Label.new()
		name_label.text = attr
		name_label.custom_minimum_size = Vector2(90, 0)
		grid.add_child(name_label)

		var minus := Button.new()
		minus.text = "-"
		minus.focus_mode = Control.FOCUS_NONE
		minus.custom_minimum_size = Vector2(28, 0)
		minus.disabled = int(_attr_values[attr]) <= int(_data.get("min_value", 1))
		minus.pressed.connect(_on_attr_delta.bind(attr, -1))
		grid.add_child(minus)

		var value_label := Label.new()
		value_label.text = str(_attr_values[attr])
		value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		value_label.custom_minimum_size = Vector2(24, 0)
		value_label.add_theme_color_override("font_color", COL_GOLD)
		grid.add_child(value_label)

		var plus := Button.new()
		plus.text = "+"
		plus.focus_mode = Control.FOCUS_NONE
		plus.custom_minimum_size = Vector2(28, 0)
		plus.disabled = int(_attr_values[attr]) >= int(_data.get("max_value", 8)) or _points_remaining() <= 0
		plus.pressed.connect(_on_attr_delta.bind(attr, 1))
		grid.add_child(plus)

	_update_points_label()


func _on_attr_delta(attr: String, delta: int) -> void:
	var min_v: int = int(_data.get("min_value", 1))
	var max_v: int = int(_data.get("max_value", 8))
	if delta > 0 and _points_remaining() <= 0:
		return
	_attr_values[attr] = clampi(int(_attr_values[attr]) + delta, min_v, max_v)
	_render_attributes()
	_refresh_next_enabled()


func _update_points_label() -> void:
	points_label.text = "Points remaining: %d / %d" % [_points_remaining(), int(_data.get("point_pool", 30))]


## --- step 1 / 2: class + background perk picks (GDD §7.4 / §7.5) --------------
func _render_class() -> void:
	_clear_host()
	points_label.hide()
	var list := VBoxContainer.new()
	list.add_theme_constant_override("separation", 6)
	step_host.add_child(list)
	for entry in _data.get("classes", []):
		var body := "%s\n%s\n%s" % [entry["lean"], entry["ability"], entry["access"]]
		list.add_child(_make_pick_card(entry["id"], entry["name"], body, _selected_class,
			_on_pick_class.bind(entry["id"])))


func _render_perk() -> void:
	_clear_host()
	points_label.hide()
	var list := VBoxContainer.new()
	list.add_theme_constant_override("separation", 6)
	step_host.add_child(list)
	for entry in _data.get("perks", []):
		var body := "Edge: %s\nCost: %s" % [entry["edge"], entry["cost"]]
		list.add_child(_make_pick_card(entry["id"], entry["name"], body, _selected_perk,
			_on_pick_perk.bind(entry["id"])))


func _on_pick_class(id: String) -> void:
	_selected_class = id
	_render_class()
	_refresh_next_enabled()


func _on_pick_perk(id: String) -> void:
	_selected_perk = id
	_render_perk()
	_refresh_next_enabled()


func _make_pick_card(id: String, title: String, body: String, selected_id: String, on_pick: Callable) -> Control:
	var is_selected := id == selected_id

	var panel := PanelContainer.new()
	var margin := MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_%s" % side, 10 if side in ["left", "right"] else 6)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	margin.add_child(vbox)

	var title_label := Label.new()
	title_label.text = ("▸ " if is_selected else "   ") + title
	title_label.add_theme_color_override("font_color", COL_SELECTED if is_selected else COL_GOLD)
	vbox.add_child(title_label)

	var body_label := Label.new()
	body_label.text = body
	body_label.add_theme_color_override("font_color", COL_NORMAL if is_selected else COL_DIM)
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(body_label)

	# Full-panel click target, layered above the text so the whole card is pickable.
	var button := Button.new()
	button.flat = true
	button.focus_mode = Control.FOCUS_NONE
	button.set_anchors_preset(Control.PRESET_FULL_RECT)
	button.pressed.connect(on_pick)
	panel.add_child(button)

	return panel


## --- step 3: summary + confirm -------------------------------------------------
func _render_summary() -> void:
	_clear_host()
	points_label.hide()

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 4)
	step_host.add_child(vbox)

	var attr_line := Label.new()
	var parts: Array[String] = []
	for attr in _data.get("attributes", []):
		parts.append("%s %d" % [attr, int(_attr_values[attr])])
	attr_line.text = "Attributes: " + ", ".join(parts)
	attr_line.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(attr_line)

	var class_line := Label.new()
	class_line.text = "Class: " + _display_name("classes", _selected_class)
	class_line.add_theme_color_override("font_color", COL_GOLD)
	vbox.add_child(class_line)

	var perk_line := Label.new()
	perk_line.text = "Background: " + _display_name("perks", _selected_perk)
	perk_line.add_theme_color_override("font_color", COL_GOLD)
	vbox.add_child(perk_line)


func _display_name(list_key: String, id: String) -> String:
	for entry in _data.get(list_key, []):
		if entry["id"] == id:
			return entry["name"]
	return "—"


## --- navigation -----------------------------------------------------------------
func _on_back() -> void:
	if _step > 0:
		_step -= 1
		_render_step()


func _on_next() -> void:
	if _step < STEP_NAMES.size() - 1:
		_step += 1
		_render_step()
	else:
		_confirm()


func _refresh_next_enabled() -> void:
	match _step:
		0: next_button.disabled = _points_remaining() != 0
		1: next_button.disabled = _selected_class.is_empty()
		2: next_button.disabled = _selected_perk.is_empty()
		_: next_button.disabled = false


func _confirm() -> void:
	for attr in _attr_values:
		GameState.set_attribute(attr, int(_attr_values[attr]))
	GameState.current_protagonist = "elorin"
	GameState.set_flag("P1_CLASS", _selected_class)
	GameState.set_flag("P1_PERK", _selected_perk)
	SceneManager.change_zone(NEXT_SCENE)
