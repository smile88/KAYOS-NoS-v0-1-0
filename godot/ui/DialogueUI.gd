extends Control
## In-world dialogue renderer (Phase 1.7 / 2). Passive: it listens to DialogueManager and shows
## the panel only during a conversation. Strain is a persistent HUD element (GDD §12). Placeholder
## styling — the illuminated-manuscript frame (UI-001..006) drops in during Phase 2 art.

const COL_NORMAL := Color(0.90, 0.88, 0.98)
const COL_GOLD := Color(0.95, 0.82, 0.42)
const COL_LOCKED := Color(0.45, 0.45, 0.52)

@onready var panel: PanelContainer = %Panel
@onready var speaker: Label = %Speaker
@onready var line: RichTextLabel = %Line
@onready var choices: VBoxContainer = %Choices
@onready var strain: Label = %Strain
@onready var portrait: TextureRect = %Portrait

## Portrait id (e.g. "PO-005") -> texture path. Cleaned art dropped into art/portraits/ wins
## over art/placeholders/ automatically — name the file with the PO-### id as its prefix.
var _portrait_index: Dictionary = {}

## The keyboard-navigable choice buttons (enabled only; locked options are shown but skipped) and the
## currently highlighted one. Driven by W/S (or up/down) to move and F (or Space/Enter) to select, so
## a conversation is played entirely on the same keys as the rest of the game.
var _nav_buttons: Array[Button] = []
var _sel := 0


func _ready() -> void:
	_build_portrait_index()
	DialogueManager.dialogue_started.connect(func(_id): panel.show())
	DialogueManager.node_entered.connect(_on_node)
	DialogueManager.choices_ready.connect(_on_choices)
	DialogueManager.dialogue_finished.connect(func(_id): panel.hide())
	GameState.strain_changed.connect(func(_v, _b): _refresh_strain())
	panel.hide()
	_refresh_strain()


func _on_node(node: Dictionary) -> void:
	speaker.text = String(node.get("speaker", "")).capitalize()
	line.text = String(node.get("text", ""))
	var pid := String(node.get("portrait", ""))
	if pid != "" and _portrait_index.has(pid):
		portrait.texture = load(_portrait_index[pid])
		portrait.show()
	else:
		portrait.texture = null
		portrait.hide()


## Scan placeholders first, then real art, so art/portraits/ overrides same-id placeholders.
func _build_portrait_index() -> void:
	for dir_path in ["res://art/placeholders", "res://art/portraits"]:
		var dir := DirAccess.open(dir_path)
		if dir == null:
			continue
		for f in dir.get_files():
			if not f.ends_with(".png"):
				continue
			var pid := f.get_basename().get_slice("_", 0)   # "PO-005_talindir.png" -> "PO-005"
			if pid.begins_with("PO-"):
				_portrait_index[pid] = dir_path + "/" + f


func _on_choices(list: Array) -> void:
	for c in choices.get_children():
		c.queue_free()
	_nav_buttons.clear()
	_sel = 0
	if list.is_empty():
		_add_button("(continue)", COL_NORMAL, true, func(): DialogueManager.advance())
		_update_selection()
		return
	for entry in list:
		var label: String = entry["text"]
		var col := COL_NORMAL
		var check = entry.get("check")
		if check != null:
			var tag := "[%s %d%s]" % [check.get("attr", "?"), int(check.get("dc", 0)),
				("  · Fortune" if entry["state"] == "uncertain" else "")]
			if entry["state"] == "locked":
				label = "🔒 %s  %s" % [tag, entry["text"]]
				col = COL_LOCKED
			else:
				label = "%s  %s" % [tag, entry["text"]]
				col = COL_GOLD
		var idx: int = entry["index"]
		_add_button(label, col, entry["enabled"], func(): DialogueManager.choose(idx))
	_update_selection()


func _add_button(text: String, col: Color, enabled: bool, on_press: Callable) -> void:
	var b := Button.new()
	b.set_meta("base_text", text)
	b.text = text
	b.disabled = not enabled
	b.add_theme_color_override("font_color", col)
	b.alignment = HORIZONTAL_ALIGNMENT_LEFT
	b.focus_mode = Control.FOCUS_NONE   # we drive selection ourselves, no click-focus surprises
	if enabled:
		b.pressed.connect(on_press)
		_nav_buttons.append(b)
	choices.add_child(b)


## Keyboard-drive the choice list: W / up move the highlight up, S / down move it down, F / Space /
## Enter select. Active only while a conversation panel is open, so it never touches world movement
## (the player is frozen during dialogue anyway).
func _unhandled_input(event: InputEvent) -> void:
	if not panel.visible or _nav_buttons.is_empty():
		return
	if event.is_action_pressed("move_up") or event.is_action_pressed("ui_up"):
		_move_sel(-1)
	elif event.is_action_pressed("move_down") or event.is_action_pressed("ui_down"):
		_move_sel(1)
	elif event.is_action_pressed("interact") or event.is_action_pressed("ui_accept"):
		_nav_buttons[_sel].pressed.emit()
	else:
		return
	get_viewport().set_input_as_handled()


func _move_sel(dir: int) -> void:
	var n := _nav_buttons.size()
	_sel = (_sel + dir + n) % n
	_update_selection()


## Highlight the selected option (bright; others dimmed) and mark it with a caret.
func _update_selection() -> void:
	for i in _nav_buttons.size():
		var b := _nav_buttons[i]
		var sel := (i == _sel)
		b.text = ("▸  " if sel else "    ") + String(b.get_meta("base_text"))
		b.modulate.a = 1.0 if sel else 0.55


func _refresh_strain() -> void:
	var band: int = GameState.get_strain_band()
	var band_name: String = ["Calm", "Frayed", "Strained", "Breaking", "Silence"][band]
	strain.text = "Mental Strain: %d / 100  (%s)" % [GameState.mental_strain, band_name]
