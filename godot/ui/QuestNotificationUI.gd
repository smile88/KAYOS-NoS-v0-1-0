extends CanvasLayer
## QuestNotificationUI — Animated top-screen banner for quest lifecycle notifications.
##
## Listens to GameState.quest_updated and displays:
## - [QUEST STARTED] <Title> - Initial objective / lore hook
## - [QUEST UPDATED] <Stage Description> - Objective progression
## - [QUEST COMPLETED] <Title> - Completion & reward announcement
## - [QUEST FAILED] <Title> - Failure notification

const COL_GOLD := Color(0.96, 0.84, 0.44)         # Gold for Start & Completed
const COL_CYAN := Color(0.48, 0.78, 0.98)         # Starfall Blue for Updates
const COL_EMERALD := Color(0.45, 0.90, 0.65)      # Completed Accent
const COL_CRIMSON := Color(0.95, 0.40, 0.40)      # Failed Accent
const COL_BG := Color(0.06, 0.07, 0.12, 0.96)     # Deep Twilight background

@onready var container: Control = %Container
@onready var banner: PanelContainer = %Banner
@onready var tag_label: Label = %TagLabel
@onready var title_label: Label = %TitleLabel
@onready var sub_label: Label = %SubLabel
@onready var icon_label: Label = %IconLabel
@onready var border_glow: ColorRect = %BorderGlow

var _queue: Array[Dictionary] = []
var _is_animating: bool = false
var _current_tween: Tween = null
var _known_stages: Dictionary = {}   # quest_id -> int
var _known_states: Dictionary = {}   # quest_id -> String

var _banner_style: StyleBoxFlat


func _ready() -> void:
	_setup_styles()
	if banner:
		banner.modulate.a = 0.0
		banner.position.y = -80.0
	
	if Engine.has_singleton("GameState") or GameState != null:
		GameState.quest_updated.connect(_on_quest_updated)
		# Initialize known states from existing quests if any
		for q_id in GameState.quests:
			var q: Dictionary = GameState.quests[q_id]
			_known_stages[q_id] = int(q.get("stage", 1))
			_known_states[q_id] = str(q.get("state", "active"))


func _setup_styles() -> void:
	_banner_style = StyleBoxFlat.new()
	_banner_style.bg_color = COL_BG
	_banner_style.border_width_left = 2
	_banner_style.border_width_right = 2
	_banner_style.border_width_top = 2
	_banner_style.border_width_bottom = 2
	_banner_style.border_color = COL_GOLD
	_banner_style.corner_radius_top_left = 6
	_banner_style.corner_radius_top_right = 6
	_banner_style.corner_radius_bottom_left = 6
	_banner_style.corner_radius_bottom_right = 6
	_banner_style.shadow_color = Color(0, 0, 0, 0.6)
	_banner_style.shadow_size = 10
	_banner_style.content_margin_left = 16
	_banner_style.content_margin_right = 16
	_banner_style.content_margin_top = 8
	_banner_style.content_margin_bottom = 8
	
	if banner:
		banner.add_theme_stylebox_override("panel", _banner_style)


func _on_quest_updated(quest_id: String, state: String, stage: int, data: Dictionary) -> void:
	var prev_state: String = _known_states.get(quest_id, "")
	var prev_stage: int = _known_stages.get(quest_id, 0)
	
	var title: String = str(data.get("title", quest_id))
	var stages: Array = data.get("stages", [])
	var stage_desc: String = ""
	if stage > 0 and stage <= stages.size():
		var s = stages[stage - 1]
		if s is Dictionary:
			stage_desc = str(s.get("desc", ""))
		else:
			stage_desc = str(s)
	
	# Determine notification event
	if state == "completed" and prev_state != "completed":
		notify_quest_completed(title, "Chronicle entry fulfilled.")
	elif state == "failed" and prev_state != "failed":
		notify_quest_failed(title)
	elif state == "active":
		if prev_state == "" or prev_state == "inactive":
			# Brand new quest started
			var initial_desc := stage_desc
			if initial_desc == "":
				initial_desc = str(data.get("desc", ""))
			notify_quest_started(title, initial_desc)
		elif stage != prev_stage:
			# Objective stage progression
			var desc_text := stage_desc
			if desc_text == "":
				desc_text = "Stage %d reached." % stage
			notify_objective_updated(title, desc_text, stage)
	
	_known_states[quest_id] = state
	_known_stages[quest_id] = stage


func notify_quest_started(title: String, desc: String = "") -> void:
	queue_notification({
		"tag": "QUEST STARTED",
		"icon": "✦",
		"title": title,
		"sub": desc,
		"color": COL_GOLD,
		"glow_color": Color(0.96, 0.84, 0.44, 0.4),
		"blip": "elorin"
	})


func notify_objective_updated(title: String, stage_desc: String, stage: int = 1) -> void:
	var sub_text := stage_desc
	if sub_text == "":
		sub_text = "Stage %d directive updated." % stage
	queue_notification({
		"tag": "QUEST UPDATED",
		"icon": "◆",
		"title": title,
		"sub": sub_text,
		"color": COL_CYAN,
		"glow_color": Color(0.48, 0.78, 0.98, 0.4),
		"blip": "talindir"
	})


func notify_quest_completed(title: String, rewards_summary: String = "") -> void:
	var sub_text := rewards_summary
	if sub_text == "":
		sub_text = "Chronicle objective fulfilled."
	queue_notification({
		"tag": "QUEST COMPLETED",
		"icon": "★",
		"title": title,
		"sub": sub_text,
		"color": COL_EMERALD,
		"glow_color": Color(0.45, 0.90, 0.65, 0.5),
		"blip": "elorin"
	})


func notify_quest_failed(title: String) -> void:
	queue_notification({
		"tag": "QUEST FAILED",
		"icon": "✕",
		"title": title,
		"sub": "This thread is severed.",
		"color": COL_CRIMSON,
		"glow_color": Color(0.95, 0.40, 0.40, 0.4),
		"blip": "morga"
	})


func queue_notification(item: Dictionary) -> void:
	_queue.append(item)
	if not _is_animating:
		_show_next()


func _show_next() -> void:
	if _queue.is_empty():
		_is_animating = false
		return
	
	_is_animating = true
	var item: Dictionary = _queue.pop_front()
	
	var tag: String = item.get("tag", "NOTICE")
	var icon: String = item.get("icon", "✦")
	var title: String = item.get("title", "")
	var sub: String = item.get("sub", "")
	var color: Color = item.get("color", COL_GOLD)
	var glow_col: Color = item.get("glow_color", Color(1, 1, 1, 0.3))
	var blip: String = item.get("blip", "default")
	
	tag_label.text = "[ %s ]" % tag
	tag_label.add_theme_color_override("font_color", color)
	
	icon_label.text = icon
	icon_label.add_theme_color_override("font_color", color)
	
	title_label.text = title
	title_label.add_theme_color_override("font_color", Color(0.95, 0.96, 1.0))
	
	sub_label.text = sub
	sub_label.visible = (sub.strip_edges() != "")
	
	if _banner_style:
		_banner_style.border_color = color
	if border_glow:
		border_glow.color = glow_col
	
	# Play acoustic chime/blip
	if AudioManager:
		AudioManager.play_dialogue_blip(blip)
	
	# Animate banner entrance -> hold -> exit
	if _current_tween and _current_tween.is_valid():
		_current_tween.kill()
	
	banner.position.y = -80.0
	banner.modulate.a = 0.0
	
	_current_tween = create_tween()
	
	# Slide Down + Fade In (0.35s)
	_current_tween.set_parallel(true)
	_current_tween.tween_property(banner, "position:y", 20.0, 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_current_tween.tween_property(banner, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# Hold Duration (2.8s)
	_current_tween.chain().tween_interval(2.8)
	
	# Slide Up + Fade Out (0.3s)
	_current_tween.chain().set_parallel(true)
	_current_tween.tween_property(banner, "position:y", -80.0, 0.30).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_current_tween.tween_property(banner, "modulate:a", 0.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	# Next item in queue
	_current_tween.chain().tween_callback(self._show_next)
