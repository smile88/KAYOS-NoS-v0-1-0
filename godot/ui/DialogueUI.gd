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


func _ready() -> void:
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


func _on_choices(list: Array) -> void:
	for c in choices.get_children():
		c.queue_free()
	if list.is_empty():
		_add_button("▸  (continue)", COL_NORMAL, true, func(): DialogueManager.advance())
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


func _add_button(text: String, col: Color, enabled: bool, on_press: Callable) -> void:
	var b := Button.new()
	b.text = text
	b.disabled = not enabled
	b.add_theme_color_override("font_color", col)
	b.alignment = HORIZONTAL_ALIGNMENT_LEFT
	if enabled:
		b.pressed.connect(on_press)
	choices.add_child(b)


func _refresh_strain() -> void:
	var band: int = GameState.get_strain_band()
	var band_name: String = ["Calm", "Frayed", "Strained", "Breaking", "Silence"][band]
	strain.text = "Mental Strain: %d / 100  (%s)" % [GameState.mental_strain, band_name]
