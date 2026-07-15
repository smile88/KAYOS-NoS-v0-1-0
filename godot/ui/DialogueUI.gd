extends Control
## Minimal but real dialogue UI (Phase 1.7). Renders DialogueManager output: speaker + line,
## choice buttons with check tags (passable=gold, locked=grey+lock, uncertain=+Fortune), and a
## live Strain readout. Placeholder styling — the illuminated-manuscript art (UI-001..006) lands
## in Phase 2. Run this scene directly to click through the §8.2 Funding Lie tree.

const CONV := "res://data/dialogue/test_funding_lie.json"

const COL_NORMAL := Color(0.90, 0.88, 0.98)
const COL_GOLD := Color(0.95, 0.82, 0.42)
const COL_LOCKED := Color(0.45, 0.45, 0.52)

@onready var speaker: Label = %Speaker
@onready var line: RichTextLabel = %Line
@onready var choices: VBoxContainer = %Choices
@onready var strain: Label = %Strain


func _ready() -> void:
	DialogueManager.node_entered.connect(_on_node)
	DialogueManager.choices_ready.connect(_on_choices)
	DialogueManager.dialogue_finished.connect(_on_finished)
	GameState.strain_changed.connect(func(_v, _b): _refresh_strain())
	# Give the test a legible starting build.
	GameState.set_flag("P1_CLASS", "harmonist")
	GameState.set_attribute("Acumen", 7)
	_refresh_strain()
	DialogueManager.start(CONV)


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
			match entry["state"]:
				"locked":
					label = "🔒 %s  %s" % [tag, entry["text"]]
					col = COL_LOCKED
				_:
					label = "%s  %s" % [tag, entry["text"]]
					col = COL_GOLD
		var idx: int = entry["index"]
		_add_button(label, col, entry["enabled"], func(): DialogueManager.choose(idx))


func _on_finished(_id: String) -> void:
	speaker.text = ""
	line.text = "[i]— end of exchange —[/i]"
	for c in choices.get_children():
		c.queue_free()
	_add_button("↻  Replay", COL_NORMAL, true, func():
		_ready())   # restart the conversation


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
