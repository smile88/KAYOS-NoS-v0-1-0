extends CanvasLayer
## QuestLogUI — Master Quest Journal & Chronicle Interface for KAYOS: The Night of Silence.
##
## Features:
## - Full two-pane chronicle ledger (Main Quests, Side Quests, Completed Quests).
## - Category tabs: "All", "Main Quests", "Side Quests", "Completed".
## - Left sidebar: Real-time quest list with badges, stage progression, and status.
## - Right pane: Comprehensive quest dossier (Title, Category, Lore, Current Objective,
##   interactive Checklist of all stages, and Recorded Rewards / Legacy Consequences).
## - Full keyboard navigation (J, Tab, W/S/Up/Down, Esc, Enter/Space) & Mouse support.
## - HUD Toggle Button with active/new quest indicator badge.
## - Reactive to GameState.quest_updated and flag events.

const COL_BG_MODAL := Color(0.03, 0.04, 0.08, 0.78)
const COL_PANEL_BG := Color(0.06, 0.07, 0.12, 0.97)
const COL_GOLD_BRIGHT := Color(0.98, 0.86, 0.46)
const COL_GOLD_MUTED := Color(0.72, 0.62, 0.35)
const COL_CYAN_STARFALL := Color(0.48, 0.78, 0.98)
const COL_PURPLE_SIDE := Color(0.76, 0.62, 0.94)
const COL_EMERALD_DONE := Color(0.45, 0.90, 0.65)
const COL_CRIMSON_FAIL := Color(0.95, 0.40, 0.40)
const COL_TEXT_MAIN := Color(0.92, 0.92, 0.98)
const COL_TEXT_MUTED := Color(0.62, 0.65, 0.76)
const COL_TEXT_FAINT := Color(0.42, 0.44, 0.54)

const COL_CARD_NORMAL := Color(0.09, 0.10, 0.17, 0.80)
const COL_CARD_HOVER := Color(0.13, 0.15, 0.24, 0.90)
const COL_CARD_SELECTED := Color(0.17, 0.19, 0.30, 0.98)

@export var open_on_start: bool = false

# UI References
@onready var root_control: Control = %RootControl
@onready var backdrop: ColorRect = %Backdrop
@onready var journal_panel: PanelContainer = %JournalPanel
@onready var close_btn: Button = %CloseBtn

# Left Pane
@onready var tab_all: Button = %TabAll
@onready var tab_main: Button = %TabMain
@onready var tab_side: Button = %TabSide
@onready var tab_completed: Button = %TabCompleted
@onready var quest_list_vbox: VBoxContainer = %QuestListVBox
@onready var empty_list_label: Label = %EmptyListLabel

# Right Pane (Details)
@onready var detail_container: VBoxContainer = %DetailContainer
@onready var empty_detail_vbox: VBoxContainer = %EmptyDetailVBox
@onready var detail_category_tag: Label = %DetailCategoryTag
@onready var detail_title: Label = %DetailTitle
@onready var detail_status_badge: Label = %DetailStatusBadge
@onready var detail_desc: RichTextLabel = %DetailDesc
@onready var current_stage_box: PanelContainer = %CurrentStageBox
@onready var current_stage_label: Label = %CurrentStageLabel
@onready var objectives_vbox: VBoxContainer = %ObjectivesVBox
@onready var rewards_section: VBoxContainer = %RewardsSection
@onready var rewards_vbox: VBoxContainer = %RewardsVBox

# Header & Footer
@onready var protagonist_label: Label = %ProtagonistLabel
@onready var footer_hints: Label = %FooterHints

# HUD Quick Toggle
@onready var hud_toggle_btn: Button = %HUDToggleBtn
@onready var hud_notification_dot: ColorRect = %HUDNotificationDot

# Internal State
var is_open: bool = false
var current_category: String = "all"   # "all" | "main" | "side" | "completed"
var selected_quest_id: String = ""

var _tab_buttons: Dictionary = {}
var _quest_buttons: Array[Button] = []
var _quest_ids_in_view: Array[String] = []
var _selected_index: int = 0
var _has_unseen_updates: bool = false

var _panel_style: StyleBoxFlat
var _stage_box_style: StyleBoxFlat


func _ready() -> void:
	layer = 35
	_setup_styles()
	_register_tabs()
	_connect_signals()
	
	# Initial visibility
	root_control.visible = true
	backdrop.visible = false
	journal_panel.visible = false
	journal_panel.modulate.a = 0.0
	
	if hud_notification_dot:
		hud_notification_dot.visible = false
	
	_refresh_tab_counts()
	
	if open_on_start:
		open_journal()


func _setup_styles() -> void:
	# Main journal panel frame
	_panel_style = StyleBoxFlat.new()
	_panel_style.bg_color = COL_PANEL_BG
	_panel_style.border_width_left = 2
	_panel_style.border_width_right = 2
	_panel_style.border_width_top = 2
	_panel_style.border_width_bottom = 2
	_panel_style.border_color = COL_GOLD_MUTED
	_panel_style.corner_radius_top_left = 8
	_panel_style.corner_radius_top_right = 8
	_panel_style.corner_radius_bottom_left = 8
	_panel_style.corner_radius_bottom_right = 8
	_panel_style.shadow_color = Color(0, 0, 0, 0.7)
	_panel_style.shadow_size = 20
	if journal_panel:
		journal_panel.add_theme_stylebox_override("panel", _panel_style)

	# Current stage highlight box
	_stage_box_style = StyleBoxFlat.new()
	_stage_box_style.bg_color = Color(0.12, 0.14, 0.22, 0.85)
	_stage_box_style.border_width_left = 3
	_stage_box_style.border_width_top = 1
	_stage_box_style.border_width_right = 1
	_stage_box_style.border_width_bottom = 1
	_stage_box_style.border_color = COL_GOLD_BRIGHT
	_stage_box_style.corner_radius_top_left = 4
	_stage_box_style.corner_radius_top_right = 4
	_stage_box_style.corner_radius_bottom_left = 4
	_stage_box_style.corner_radius_bottom_right = 4
	_stage_box_style.content_margin_left = 12
	_stage_box_style.content_margin_right = 12
	_stage_box_style.content_margin_top = 8
	_stage_box_style.content_margin_bottom = 8
	if current_stage_box:
		current_stage_box.add_theme_stylebox_override("panel", _stage_box_style)


func _register_tabs() -> void:
	_tab_buttons = {
		"all": tab_all,
		"main": tab_main,
		"side": tab_side,
		"completed": tab_completed
	}
	
	for cat_key in _tab_buttons:
		var cat: String = str(cat_key)
		var btn: Button = _tab_buttons[cat]
		if btn:
			btn.pressed.connect(func(): set_category(cat))


func _connect_signals() -> void:
	if close_btn:
		close_btn.pressed.connect(close_journal)
	
	if hud_toggle_btn:
		hud_toggle_btn.pressed.connect(toggle_journal)
	
	if backdrop:
		backdrop.gui_input.connect(func(ev: InputEvent):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				close_journal()
		)
	
	if Engine.has_singleton("GameState") or GameState != null:
		GameState.quest_updated.connect(_on_quest_updated)


func _unhandled_input(event: InputEvent) -> void:
	# Check Journal Toggle Key ('J', 'Tab', or Action "journal" / "quest_log")
	var action_journal = InputMap.has_action("journal") and event.is_action_pressed("journal")
	var action_quest_log = InputMap.has_action("quest_log") and event.is_action_pressed("quest_log")
	if action_journal or action_quest_log:
		toggle_journal()
		get_viewport().set_input_as_handled()
		return
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_J:
			toggle_journal()
			get_viewport().set_input_as_handled()
			return
	
	# If journal is closed, ignore other inputs
	if not is_open:
		return
	
	# When open, handle modal keys
	if event.is_action_pressed("ui_cancel") or (event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE):
		close_journal()
		get_viewport().set_input_as_handled()
		return
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_TAB:
			_cycle_tab(1 if not event.shift_pressed else -1)
			get_viewport().set_input_as_handled()
			return
	
	# List navigation
	if event.is_action_pressed("ui_up") or event.is_action_pressed("move_up") or (event is InputEventKey and event.pressed and event.keycode == KEY_W):
		_navigate_list(-1)
		get_viewport().set_input_as_handled()
		return
	elif event.is_action_pressed("ui_down") or event.is_action_pressed("move_down") or (event is InputEventKey and event.pressed and event.keycode == KEY_S):
		_navigate_list(1)
		get_viewport().set_input_as_handled()
		return


## Open the Journal Interface
func open_journal(target_quest_id: String = "") -> void:
	if is_open:
		return
	
	is_open = true
	_has_unseen_updates = false
	if hud_notification_dot:
		hud_notification_dot.visible = false
	
	_refresh_protagonist_context()
	backdrop.visible = true
	journal_panel.visible = true
	
	# Open animation
	var tween := create_tween().set_parallel(true)
	journal_panel.scale = Vector2(0.97, 0.97)
	journal_panel.pivot_offset = journal_panel.size / 2.0
	tween.tween_property(journal_panel, "scale", Vector2.ONE, 0.18).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(journal_panel, "modulate:a", 1.0, 0.18).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(backdrop, "modulate:a", 1.0, 0.18)
	
	if AudioManager:
		AudioManager.play_dialogue_blip("talindir")
	
	_refresh_tab_counts()
	
	if target_quest_id != "":
		var q: Dictionary = GameState.get_quest(target_quest_id)
		if not q.is_empty():
			var q_cat: String = str(q.get("category", "side"))
			var q_state: String = str(q.get("state", "active"))
			if q_state == "completed":
				set_category("completed")
			else:
				set_category(q_cat if _tab_buttons.has(q_cat) else "all")
			_select_quest(target_quest_id)
			return
	
	_refresh_quest_list()


## Close the Journal Interface
func close_journal() -> void:
	if not is_open:
		return
	
	is_open = false
	var tween := create_tween().set_parallel(true)
	tween.tween_property(journal_panel, "modulate:a", 0.0, 0.14).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(backdrop, "modulate:a", 0.0, 0.14)
	tween.chain().tween_callback(func():
		backdrop.visible = false
		journal_panel.visible = false
	)


## Toggle open / closed state
func toggle_journal() -> void:
	if is_open:
		close_journal()
	else:
		open_journal()


## Set Category Tab ("all", "main", "side", "completed")
func set_category(cat: String) -> void:
	current_category = cat
	_update_tab_visuals()
	_refresh_quest_list()


func _cycle_tab(dir: int) -> void:
	var keys := ["all", "main", "side", "completed"]
	var idx := keys.find(current_category)
	if idx == -1:
		idx = 0
	var next_idx := (idx + dir + keys.size()) % keys.size()
	set_category(keys[next_idx])


func _update_tab_visuals() -> void:
	for cat_key in _tab_buttons:
		var cat: String = str(cat_key)
		var btn: Button = _tab_buttons[cat]
		if not btn:
			continue
		var is_active: bool = (cat == current_category)
		var base_text: String = String(btn.get_meta("base_name", btn.text))
		btn.text = ("✦ " + base_text) if is_active else base_text
		btn.add_theme_color_override("font_color", COL_GOLD_BRIGHT if is_active else COL_TEXT_MUTED)
		btn.modulate.a = 1.0 if is_active else 0.7


func _refresh_tab_counts() -> void:
	if not Engine.has_singleton("GameState") and GameState == null:
		return
	
	var total_all := 0
	var total_main := 0
	var total_side := 0
	var total_done := 0
	
	for q_id_key in GameState.quests:
		var q_id: String = str(q_id_key)
		var q: Dictionary = GameState.quests[q_id]
		var state: String = str(q.get("state", "active"))
		var cat: String = str(q.get("category", "side"))
		
		if state == "completed":
			total_done += 1
			total_all += 1
		elif state == "active":
			total_all += 1
			if cat == "main":
				total_main += 1
			else:
				total_side += 1
	
	_set_tab_label(tab_all, "All", total_all)
	_set_tab_label(tab_main, "Main Quests", total_main)
	_set_tab_label(tab_side, "Side Quests", total_side)
	_set_tab_label(tab_completed, "Completed", total_done)
	_update_tab_visuals()


func _set_tab_label(btn: Button, base_name: String, count: int) -> void:
	if btn == null:
		return
	var label_str := "%s (%d)" % [base_name, count]
	btn.set_meta("base_name", label_str)
	btn.text = label_str


func _refresh_quest_list() -> void:
	for child in quest_list_vbox.get_children():
		quest_list_vbox.remove_child(child)
		child.queue_free()
	
	_quest_buttons.clear()
	_quest_ids_in_view.clear()
	
	if not Engine.has_singleton("GameState") and GameState == null:
		_show_empty_list()
		return
	
	var list: Array[Dictionary] = []
	for q_id_key in GameState.quests:
		var q_id: String = str(q_id_key)
		var q: Dictionary = GameState.quests[q_id]
		var state: String = str(q.get("state", "active"))
		var cat: String = str(q.get("category", "side"))
		
		match current_category:
			"all":
				list.append(q)
			"main":
				if cat == "main" and state == "active":
					list.append(q)
			"side":
				if cat == "side" and state == "active":
					list.append(q)
			"completed":
				if state == "completed":
					list.append(q)
	
	# Sort: Active Main -> Active Side -> Completed -> Failed
	list.sort_custom(func(a: Dictionary, b: Dictionary) -> bool:
		var a_state := str(a.get("state", "active"))
		var b_state := str(b.get("state", "active"))
		if a_state != b_state:
			if a_state == "active": return true
			if b_state == "active": return false
		var a_cat := str(a.get("category", "side"))
		var b_cat := str(b.get("category", "side"))
		if a_cat != b_cat:
			return a_cat == "main"
		return str(a.get("title", "")) < str(b.get("title", ""))
	)
	
	if list.is_empty():
		_show_empty_list()
		return
	
	empty_list_label.visible = false
	
	for i in list.size():
		var q: Dictionary = list[i]
		var q_id := str(q.get("id", ""))
		var btn := _create_quest_card_button(q, i)
		quest_list_vbox.add_child(btn)
		_quest_buttons.append(btn)
		_quest_ids_in_view.append(q_id)
	
	# Maintain or select first
	var target_idx := _quest_ids_in_view.find(selected_quest_id)
	if target_idx == -1:
		target_idx = 0
	
	_selected_index = target_idx
	if not _quest_ids_in_view.is_empty():
		_select_quest(_quest_ids_in_view[_selected_index])


func _show_empty_list() -> void:
	empty_list_label.visible = true
	match current_category:
		"main":
			empty_list_label.text = "No active Main Quests recorded."
		"side":
			empty_list_label.text = "No active Side Quests discovered."
		"completed":
			empty_list_label.text = "No completed chronicles yet."
		_:
			empty_list_label.text = "Chronicle is empty."
	
	detail_container.visible = false
	empty_detail_vbox.visible = true


func _create_quest_card_button(q: Dictionary, _index: int) -> Button:
	var q_id := str(q.get("id", ""))
	var title := str(q.get("title", "Untitled Chronicle"))
	var state := str(q.get("state", "active"))
	var cat := str(q.get("category", "side"))
	var stage := int(q.get("stage", 1))
	var stages: Array = q.get("stages", [])
	
	var btn := Button.new()
	btn.custom_minimum_size = Vector2(0, 48)
	btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
	btn.focus_mode = Control.FOCUS_NONE
	
	# Layout inside button
	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_top", 6)
	margin.add_theme_constant_override("margin_bottom", 6)
	
	var hbox := HBoxContainer.new()
	hbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hbox.add_theme_constant_override("separation", 8)
	
	# Badge icon / indicator
	var icon_lbl := Label.new()
	icon_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if state == "completed":
		icon_lbl.text = "✓"
		icon_lbl.add_theme_color_override("font_color", COL_EMERALD_DONE)
	elif state == "failed":
		icon_lbl.text = "✕"
		icon_lbl.add_theme_color_override("font_color", COL_CRIMSON_FAIL)
	elif cat == "main":
		icon_lbl.text = "✦"
		icon_lbl.add_theme_color_override("font_color", COL_GOLD_BRIGHT)
	else:
		icon_lbl.text = "◆"
		icon_lbl.add_theme_color_override("font_color", COL_PURPLE_SIDE)
	
	var vbox := VBoxContainer.new()
	vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.add_theme_constant_override("separation", 2)
	
	var title_lbl := Label.new()
	title_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title_lbl.text = title
	title_lbl.add_theme_font_size_override("font_size", 13)
	title_lbl.add_theme_color_override("font_color", COL_TEXT_MAIN)
	
	var sub_lbl := Label.new()
	sub_lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sub_lbl.add_theme_font_size_override("font_size", 11)
	if state == "completed":
		sub_lbl.text = "Completed"
		sub_lbl.add_theme_color_override("font_color", COL_EMERALD_DONE)
	elif stages.size() > 0:
		sub_lbl.text = "Stage %d / %d" % [stage, stages.size()]
		sub_lbl.add_theme_color_override("font_color", COL_TEXT_MUTED)
	else:
		sub_lbl.text = "In Progress"
		sub_lbl.add_theme_color_override("font_color", COL_TEXT_MUTED)
	
	vbox.add_child(title_lbl)
	vbox.add_child(sub_lbl)
	
	hbox.add_child(icon_lbl)
	hbox.add_child(vbox)
	margin.add_child(hbox)
	btn.add_child(margin)
	
	# StyleBox
	_apply_card_style(btn, false)
	
	btn.pressed.connect(func(): _select_quest(q_id))
	return btn


func _apply_card_style(btn: Button, is_selected: bool) -> void:
	var sbox := StyleBoxFlat.new()
	sbox.bg_color = COL_CARD_SELECTED if is_selected else COL_CARD_NORMAL
	sbox.border_width_left = 4 if is_selected else 2
	sbox.border_color = COL_GOLD_BRIGHT if is_selected else Color(0.20, 0.22, 0.32, 0.6)
	sbox.corner_radius_top_left = 4
	sbox.corner_radius_top_right = 4
	sbox.corner_radius_bottom_left = 4
	sbox.corner_radius_bottom_right = 4
	
	var sbox_hover := sbox.duplicate() as StyleBoxFlat
	sbox_hover.bg_color = COL_CARD_HOVER
	sbox_hover.border_color = COL_GOLD_MUTED
	
	btn.add_theme_stylebox_override("normal", sbox)
	btn.add_theme_stylebox_override("hover", sbox_hover)
	btn.add_theme_stylebox_override("pressed", sbox)


func _navigate_list(dir: int) -> void:
	var n := _quest_ids_in_view.size()
	if n == 0:
		return
	_selected_index = (_selected_index + dir + n) % n
	_select_quest(_quest_ids_in_view[_selected_index])


func _select_quest(q_id: String) -> void:
	selected_quest_id = q_id
	_selected_index = _quest_ids_in_view.find(q_id)
	
	# Refresh button highlights
	for i in _quest_buttons.size():
		var is_sel: bool = (_quest_ids_in_view[i] == q_id)
		_apply_card_style(_quest_buttons[i], is_sel)
	
	_display_quest_details(q_id)


func _display_quest_details(q_id: String) -> void:
	if not GameState.quests.has(q_id):
		detail_container.visible = false
		empty_detail_vbox.visible = true
		return
	
	var q: Dictionary = GameState.quests[q_id]
	detail_container.visible = true
	empty_detail_vbox.visible = false
	
	var title := str(q.get("title", "Untitled"))
	var desc := str(q.get("desc", ""))
	var cat := str(q.get("category", "side"))
	var state := str(q.get("state", "active"))
	var current_stage := int(q.get("stage", 1))
	var stages: Array = q.get("stages", [])
	var rewards: Dictionary = q.get("rewards", {})
	
	# Header & Tag
	if cat == "main":
		detail_category_tag.text = "✦  MAIN QUEST  ·  PRIMARY SPINE"
		detail_category_tag.add_theme_color_override("font_color", COL_GOLD_BRIGHT)
	else:
		detail_category_tag.text = "◆  SIDE QUEST  ·  STARFALL THREAD"
		detail_category_tag.add_theme_color_override("font_color", COL_PURPLE_SIDE)
	
	detail_title.text = title
	
	# Status Badge
	match state:
		"completed":
			detail_status_badge.text = "[ COMPLETED ]"
			detail_status_badge.add_theme_color_override("font_color", COL_EMERALD_DONE)
		"failed":
			detail_status_badge.text = "[ FAILED ]"
			detail_status_badge.add_theme_color_override("font_color", COL_CRIMSON_FAIL)
		_:
			detail_status_badge.text = "[ IN PROGRESS ]"
			detail_status_badge.add_theme_color_override("font_color", COL_CYAN_STARFALL)
	
	# Lore / Description
	detail_desc.text = desc
	
	# Current Directive Highlight
	var current_stage_text := ""
	if state == "completed":
		current_stage_text = "All directives fulfilled. The chronicle holds this truth."
	elif state == "failed":
		current_stage_text = "This thread was severed before resolution."
	elif current_stage > 0 and current_stage <= stages.size():
		var s = stages[current_stage - 1]
		current_stage_text = str(s.get("desc", "")) if s is Dictionary else str(s)
	else:
		current_stage_text = "Explore Starfall to advance this chronicle."
	
	current_stage_label.text = current_stage_text
	
	# Objectives Checklist
	for child in objectives_vbox.get_children():
		objectives_vbox.remove_child(child)
		child.queue_free()
	
	if stages.is_empty():
		var item_lbl := Label.new()
		item_lbl.text = "• " + current_stage_text
		item_lbl.add_theme_color_override("font_color", COL_TEXT_MAIN)
		objectives_vbox.add_child(item_lbl)
	else:
		for i in stages.size():
			var s_num := i + 1
			var s = stages[i]
			var s_text := str(s.get("desc", "")) if s is Dictionary else str(s)
			
			var hbox := HBoxContainer.new()
			hbox.add_theme_constant_override("separation", 8)
			
			var bullet := Label.new()
			var text_lbl := Label.new()
			text_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			text_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			if state == "completed" or s_num < current_stage:
				bullet.text = "✓"
				bullet.add_theme_color_override("font_color", COL_EMERALD_DONE)
				text_lbl.text = s_text
				text_lbl.add_theme_color_override("font_color", COL_TEXT_MUTED)
			elif s_num == current_stage and state == "active":
				bullet.text = "▸"
				bullet.add_theme_color_override("font_color", COL_GOLD_BRIGHT)
				text_lbl.text = s_text
				text_lbl.add_theme_color_override("font_color", COL_GOLD_BRIGHT)
			else:
				bullet.text = "·"
				bullet.add_theme_color_override("font_color", COL_TEXT_FAINT)
				text_lbl.text = s_text
				text_lbl.add_theme_color_override("font_color", COL_TEXT_FAINT)
			
			hbox.add_child(bullet)
			hbox.add_child(text_lbl)
			objectives_vbox.add_child(hbox)
	
	# Rewards / Legacy Foothold Section
	for child in rewards_vbox.get_children():
		rewards_vbox.remove_child(child)
		child.queue_free()
	
	if rewards.is_empty():
		rewards_section.visible = false
	else:
		rewards_section.visible = true
		for k_key in rewards:
			var k: String = str(k_key)
			var r_val = rewards[k]
			var r_lbl := Label.new()
			r_lbl.text = "✦ %s: %s" % [k.capitalize(), str(r_val)]
			r_lbl.add_theme_font_size_override("font_size", 12)
			r_lbl.add_theme_color_override("font_color", COL_GOLD_MUTED)
			rewards_vbox.add_child(r_lbl)


func _refresh_protagonist_context() -> void:
	if not Engine.has_singleton("GameState") and GameState == null:
		return
	var prot := GameState.current_protagonist.capitalize()
	var role := ""
	match GameState.current_protagonist:
		"elorin":
			role = "Chief Architect · Nullstone Facility (Part One)"
		"grakkar":
			role = "Chainbreaker · The Ashpile (Part Two)"
		"talindir":
			role = "Chronicler · The Observation Balcony (Cold Open)"
		_:
			role = "Wanderer of Starfall"
	protagonist_label.text = "Chronicle of: %s — %s" % [prot, role]


func _on_quest_updated(_quest_id: String, _state: String, _stage: int, _data: Dictionary) -> void:
	_refresh_tab_counts()
	
	if is_open:
		_refresh_quest_list()
	else:
		_has_unseen_updates = true
		if hud_notification_dot:
			hud_notification_dot.visible = true
