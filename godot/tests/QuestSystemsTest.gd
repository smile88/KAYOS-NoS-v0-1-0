extends Node
## QuestSystemsTest — Automated headless verification suite for Quest Management,
## QuestLogUI, and QuestNotificationUI systems.

var _pass_count := 0
var _fail_count := 0


func _ready() -> void:
	print("\n==== Starting Quest Systems Test Suite ====\n")
	
	_test_gamestate_quest_lifecycle()
	_test_gamestate_persistence()
	_test_quest_log_ui()
	_test_quest_notification_ui()
	
	print("\n==== Quest Systems Test Results: %d passed, %d failed ====\n" % [_pass_count, _fail_count])
	
	if _fail_count > 0:
		push_error("Quest Systems tests failed!")
	
	get_tree().quit(0 if _fail_count == 0 else 1)


func _assert(condition: bool, description: String) -> void:
	if condition:
		_pass_count += 1
		print("  [PASS] %s" % description)
	else:
		_fail_count += 1
		print("  [FAIL] %s" % description)


func _test_gamestate_quest_lifecycle() -> void:
	GameState.reset()
	_assert(GameState.quests.is_empty(), "GameState.reset clears all active quests")
	
	# Start Main Quest
	GameState.start_quest(
		"MQ-001",
		"The Cold Open",
		"Witness the final hour before the Nullstone activation atop Astra'Thalas.",
		"main",
		["Survey the festival crowds below", "Speak with the Grand Archmage", "Document the fading light"],
		{"Acumen": "+1", "Strain": -10}
	)
	
	_assert(GameState.has_flag("COLDOPEN_HONEST") != null, "Flags system operational alongside quests")
	_assert(GameState.quests.has("MQ-001"), "start_quest registers quest ID")
	_assert(GameState.get_quest_state("MQ-001") == "active", "quest state is active on start")
	_assert(GameState.get_active_quests().size() == 1, "get_active_quests returns 1 active quest")
	
	# Start Side Quest
	GameState.start_quest(
		"SQ-P1-01",
		"Vara's Name",
		"A human prodigy's research is being suppressed under an elder elf's seal.",
		"side",
		["Find Vara in the Academy courtyard", "Review the research drafts", "Submit the attribution petition"],
		{"Legacy": "Vara's Scholarly Lineage"}
	)
	
	_assert(GameState.get_active_quests().size() == 2, "get_active_quests returns 2 active quests")
	
	# Advance Stage
	GameState.set_quest_stage("SQ-P1-01", 2, "Review the research drafts in the Scriptorium")
	var q_sq: Dictionary = GameState.get_quest("SQ-P1-01")
	_assert(int(q_sq.get("stage", 0)) == 2, "set_quest_stage updates current stage to 2")
	
	# Complete Quest
	GameState.complete_quest("SQ-P1-01", {"Item": "Academy Pass"})
	_assert(GameState.get_quest_state("SQ-P1-01") == "completed", "complete_quest transitions state to completed")
	_assert(GameState.get_active_quests().size() == 1, "Active quests down to 1 after completion")
	_assert(GameState.get_completed_quests().size() == 1, "get_completed_quests returns completed quest")
	
	var completed_q: Dictionary = GameState.get_quest("SQ-P1-01")
	var rewards: Dictionary = completed_q.get("rewards", {})
	_assert(rewards.has("Item") and rewards.has("Legacy"), "Rewards merged on completion")


func _test_gamestate_persistence() -> void:
	GameState.save_game()
	
	# Clear memory
	GameState.quests.clear()
	_assert(GameState.quests.is_empty(), "Memory cleared before load test")
	
	# Load from disk
	var loaded := GameState.load_game()
	_assert(loaded, "GameState.load_game returns true")
	_assert(GameState.quests.has("MQ-001"), "Main quest persisted and reloaded from JSON save")
	_assert(GameState.quests.has("SQ-P1-01"), "Completed side quest persisted and reloaded")
	_assert(GameState.get_quest_state("SQ-P1-01") == "completed", "Completed state preserved across reload")


func _test_quest_log_ui() -> void:
	var quest_ui_scene := load("res://ui/QuestLogUI.tscn") as PackedScene
	_assert(quest_ui_scene != null, "QuestLogUI.tscn loads successfully")
	
	var quest_ui = quest_ui_scene.instantiate()
	add_child(quest_ui)
	
	_assert(quest_ui != null, "QuestLogUI instantiates in tree")
	_assert(not quest_ui.is_open, "QuestLogUI starts closed by default")
	
	# Test opening
	quest_ui.open_journal()
	_assert(quest_ui.is_open, "open_journal() sets is_open to true")
	_assert(quest_ui.journal_panel.visible, "Journal panel becomes visible")
	_assert(quest_ui.backdrop.visible, "Backdrop becomes visible")
	
	# Test category switching
	quest_ui.set_category("main")
	_assert(quest_ui.current_category == "main", "set_category('main') switches active tab")
	_assert(quest_ui._quest_ids_in_view.has("MQ-001"), "Main quest listed under 'main' tab")
	_assert(not quest_ui._quest_ids_in_view.has("SQ-P1-01"), "Completed side quest filtered out of 'main' tab")
	
	quest_ui.set_category("completed")
	_assert(quest_ui.current_category == "completed", "set_category('completed') switches active tab")
	_assert(quest_ui._quest_ids_in_view.has("SQ-P1-01"), "Completed quest listed under 'completed' tab")
	
	# Test quest details view
	quest_ui._select_quest("MQ-001")
	_assert(quest_ui.detail_title.text == "The Cold Open", "Selected quest title matches MQ-001")
	_assert(quest_ui.current_stage_label.text.contains("Survey the festival"), "Current stage directive displayed")
	_assert(quest_ui.objectives_vbox.get_child_count() == 3, "All 3 objectives populated in checklist")
	
	# Test closing
	quest_ui.close_journal()
	_assert(not quest_ui.is_open, "close_journal() sets is_open to false")
	
	# Test toggle
	quest_ui.toggle_journal()
	_assert(quest_ui.is_open, "toggle_journal() opens when closed")
	quest_ui.toggle_journal()
	_assert(not quest_ui.is_open, "toggle_journal() closes when open")
	
	quest_ui.queue_free()


func _test_quest_notification_ui() -> void:
	var notif_scene := load("res://ui/QuestNotificationUI.tscn") as PackedScene
	_assert(notif_scene != null, "QuestNotificationUI.tscn loads successfully")
	
	var notif_ui = notif_scene.instantiate()
	add_child(notif_ui)
	_assert(notif_ui != null, "QuestNotificationUI instantiates in tree")
	
	# Test programmatic notifications
	notif_ui.notify_quest_started("The Buried Flaw", "Elorin's private investigation.")
	_assert(notif_ui._is_animating or notif_ui._queue.size() > 0, "notify_quest_started triggers banner animation/queue")
	_assert(notif_ui.title_label.text == "The Buried Flaw", "Notification title matches requested quest")
	_assert(notif_ui.tag_label.text.contains("QUEST STARTED"), "Notification tag indicates start event")
	
	notif_ui.notify_objective_updated("The Buried Flaw", "Find the archival bypass seal", 2)
	_assert(notif_ui._queue.size() > 0, "Subsequent notifications queued properly")
	
	notif_ui.notify_quest_completed("The Buried Flaw")
	_assert(notif_ui._queue.size() == 2, "Multiple notifications maintain ordered queue")
	
	notif_ui.queue_free()
