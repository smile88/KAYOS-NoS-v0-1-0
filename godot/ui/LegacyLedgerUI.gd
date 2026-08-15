extends CanvasLayer
## The Legacy Ledger UI (GDD §5.6)
## Displays the Indigo Column (Part 1 - The choices Elorin made) and the 
## Rust Column (Part 2 - Uncovered echoes by Grakkar) with glowing threads.

const COL_INDIGO := Color(0.20, 0.25, 0.45)
const COL_RUST := Color(0.65, 0.35, 0.20)
const COL_GOLD := Color(0.95, 0.82, 0.42)

@onready var root_control: Control = %RootControl

# We will repurpose the QuestLog layout:
@onready var p1_list: VBoxContainer = %QuestListVBox
@onready var details_title: Label = %DetailTitle
@onready var details_desc: RichTextLabel = %DetailDesc

var _entry_buttons: Array[Button] = []

# The registry of known legacy moments to display:
var legacy_entries := [
	{
		"id": "vault_flaw",
		"p1_flag": "P1_FIRSTTEST_BLAME",
		"title": "The Vault Containment Flaw",
		"p1_text": {
			"ELORIN": "You took responsibility for the surge blowout, marking your own name in the archive.",
			"COIL": "You shifted the blame onto Coil, preserving your authority but earning his quiet resentment.",
			"VARA": "You blamed Vara's calculations. The prodigy took the fall."
		},
		"p2_flag": "P2_VAULT_ECHO",
		"p2_text": "Four centuries later, the maintenance records still bear that falsified stain, redirecting structural repairs away from the true fracture."
	},
	{
		"id": "funding_truth",
		"p1_flag": "P1_FUNDING",
		"title": "The Conclave Funding Report",
		"p1_text": {
			"TRUTH": "You reported the exact nature of the planar tear to the Conclave, ensuring adequate but panicked funding.",
			"LIE": "You downplayed the tear to preserve the project's autonomy.",
			"HEDGE": "You obscured the specifics, buying time."
		},
		"p2_flag": "P2_CONCLAVE_RUIN",
		"p2_text": "The city's emergency reserves were drawn down based on that report, leaving the outer rings vulnerable when the Silence fell."
	}
]

func _ready() -> void:
	root_control.hide()

func _unhandled_input(event: InputEvent) -> void:
	var toggle_pressed := false
	if InputMap.has_action("toggle_legacy_ledger") and event.is_action_pressed("toggle_legacy_ledger"):
		toggle_pressed = true
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_L:
		toggle_pressed = true
		
	if toggle_pressed or (root_control.visible and event.is_action_pressed("ui_cancel")):
		toggle_ledger()
		get_viewport().set_input_as_handled()

func toggle_ledger() -> void:
	if root_control.visible:
		root_control.hide()
		get_tree().paused = false
	else:
		_refresh_list()
		root_control.show()
		get_tree().paused = true
		if _entry_buttons.size() > 0:
			_entry_buttons[0].grab_focus()
			_on_entry_selected(0)
		else:
			_clear_details()

func _refresh_list() -> void:
	for c in p1_list.get_children():
		c.queue_free()
	_entry_buttons.clear()
	
	for i in range(legacy_entries.size()):
		var entry = legacy_entries[i]
		var p1_val = GameState.get_flag(entry["p1_flag"])
		if p1_val != null:
			var b := Button.new()
			b.text = entry["title"]
			b.alignment = HORIZONTAL_ALIGNMENT_LEFT
			b.add_theme_color_override("font_color", COL_INDIGO.lerp(Color.WHITE, 0.4))
			b.pressed.connect(func(): _on_entry_selected(i))
			p1_list.add_child(b)
			_entry_buttons.append(b)

func _on_entry_selected(entry_idx: int) -> void:
	var entry = legacy_entries[entry_idx]
	
	details_title.text = entry["title"]
	
	var p1_val = GameState.get_flag(entry["p1_flag"])
	var p1_str = entry["p1_text"].get(str(p1_val), "The decision was made, and buried.")
	
	var desc := "[color=#99aadd][b]~1456 AO (The Architect)[/b][/color]\n"
	desc += p1_str + "\n\n"
	
	if GameState.has_flag(entry["p2_flag"]):
		desc += "[color=#dd8855][b]~2000 AO (The Unbound)[/b][/color]\n"
		desc += entry["p2_text"]
	else:
		desc += "[color=#555555][i]The ripples of this choice have not yet been uncovered...[/i][/color]"
		
	details_desc.text = desc

func _clear_details() -> void:
	details_title.text = "The Legacy Ledger"
	details_desc.text = "[color=#777777]Select an echo from the past to view its resonance.[/color]"
