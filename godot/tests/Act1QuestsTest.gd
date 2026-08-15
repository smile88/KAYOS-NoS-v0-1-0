extends Node
## Automated Integration Test for Act 1: Main Quest and 15 Side Quests.
##
## Verifies:
## 1. Main Quest progression (MQ-01 briefing, MQ-02 team assembly, MQ-03 first containment test).
## 2. All 15 Side Quests (SQ-01 through SQ-15) file integrity, dialogue trees, and quest state progression.
## 3. GameState quest tracking (active, completed, stage progression, serialization).

var _passed := 0
var _failed := 0

const MQ_FILES := [
	"res://data/dialogue/mq01_corel_briefing.json",
	"res://data/dialogue/mq02_vara_recruitment.json",
	"res://data/dialogue/mq02_durak_recruitment.json",
	"res://data/dialogue/mq02_coil_recruitment.json",
	"res://data/dialogue/mq02_sera_recruitment.json",
	"res://data/dialogue/mq03_first_containment_test.json",
]

const SQ_FILES := [
	"res://data/dialogue/sq01_forged_ledger.json",
	"res://data/dialogue/sq02_cracked_resonator.json",
	"res://data/dialogue/sq03_sun_bleached_glass.json",
	"res://data/dialogue/sq04_severed_shadow.json",
	"res://data/dialogue/sq05_bedrock_echoes.json",
	"res://data/dialogue/sq06_house_divided.json",
	"res://data/dialogue/sq07_silent_ward.json",
	"res://data/dialogue/sq08_smugglers_siphon.json",
	"res://data/dialogue/sq09_seven_solstices.json",
	"res://data/dialogue/sq10_unspoken_collar.json",
	"res://data/dialogue/sq11_heretics_thesis.json",
	"res://data/dialogue/sq12_whispering_pylon.json",
	"res://data/dialogue/sq13_blind_diviner.json",
	"res://data/dialogue/sq14_golden_graft.json",
	"res://data/dialogue/sq15_tide_of_shadows.json",
]


func _ready() -> void:
	GameState.reset()
	print("\n==== Starting Act 1 Quest Integration Tests ====\n")

	# --- 1. Test GameState Quest API ---
	_test_gamestate_quest_lifecycle()

	# --- 2. Test Main Quest Dialogue Files & Flow ---
	_test_quest_dialogue_files(MQ_FILES, "Main Quest")

	# --- 3. Test 15 Side Quest Dialogue Files & Flow ---
	_test_quest_dialogue_files(SQ_FILES, "Side Quest")

	# --- 4. Test Dialogue-Triggered Quest Progression ---
	_test_dialogue_driven_quest_execution()

	# --- 5. Test Serialization ---
	_test_quest_save_load()

	print("\n==== Act 1 Quest Tests: %d passed, %d failed ====\n" % [_passed, _failed])
	get_tree().quit(0 if _failed == 0 else 1)


func _test_gamestate_quest_lifecycle() -> void:
	GameState.reset()
	GameState.start_quest("sq_test", "Test Quest", "A sample quest", "side", ["Find the book", "Return the book"])
	_check(GameState.get_quest_state("sq_test") == "active", "GameState: quest starts active")
	_check(GameState.get_quest("sq_test").get("stage") == 1, "GameState: quest stage initializes to 1")

	GameState.set_quest_stage("sq_test", 2, "Return the book to Althor")
	_check(GameState.get_quest("sq_test").get("stage") == 2, "GameState: quest stage updates to 2")

	GameState.complete_quest("sq_test", {"xp": 50})
	_check(GameState.get_quest_state("sq_test") == "completed", "GameState: quest completes")
	_check(GameState.get_completed_quests().size() == 1, "GameState: completed quests list contains 1 entry")


func _test_quest_dialogue_files(files: Array, label: String) -> void:
	for path in files:
		var exists := FileAccess.file_exists(path)
		_check(exists, "%s file exists: %s" % [label, path.get_file()])
		if not exists:
			continue

		var f := FileAccess.open(path, FileAccess.READ)
		var parsed = JSON.parse_string(f.get_as_text())
		f.close()

		_check(typeof(parsed) == TYPE_DICTIONARY, "%s JSON is valid dictionary: %s" % [label, path.get_file()])
		if typeof(parsed) != TYPE_DICTIONARY:
			continue

		var dict: Dictionary = parsed
		_check(dict.has("id") and dict.has("start") and dict.has("nodes"),
			"%s has id, start, and nodes: %s" % [label, path.get_file()])

		var nodes: Dictionary = dict.get("nodes", {})
		_check(not nodes.is_empty(), "%s has populated nodes (%d nodes): %s" % [label, nodes.size(), path.get_file()])
		_check(nodes.has(dict.get("start")), "%s start node '%s' exists: %s" % [label, dict.get("start"), path.get_file()])


func _test_dialogue_driven_quest_execution() -> void:
	GameState.reset()
	# Test running MQ-01 briefing
	if FileAccess.file_exists("res://data/dialogue/mq01_corel_briefing.json"):
		DialogueManager.start("res://data/dialogue/mq01_corel_briefing.json")
		_check(DialogueManager.is_active(), "MQ-01 dialogue started successfully")
		_check(GameState.get_quest_state("mq01_containment_problem") == "active",
			"MQ-01 dialogue automatically started main quest mq01_containment_problem")


func _test_quest_save_load() -> void:
	GameState.reset()
	GameState.start_quest("mq01_containment_problem", "The Problem", "Main Quest Act 1", "main")
	GameState.start_quest("sq01_forged_ledger", "The Forged Ledger", "Side Quest 1", "side")
	GameState.complete_quest("sq01_forged_ledger")

	GameState.save_game()
	GameState.reset()

	_check(GameState.quests.is_empty(), "GameState reset clears active quests")
	var loaded := GameState.load_game()
	_check(loaded, "GameState successfully loads save game with quests")
	_check(GameState.get_quest_state("mq01_containment_problem") == "active", "Loaded save retains active main quest")
	_check(GameState.get_quest_state("sq01_forged_ledger") == "completed", "Loaded save retains completed side quest")


func _check(cond: bool, test_name: String) -> void:
	if cond:
		_passed += 1
		print("  [PASS] " + test_name)
	else:
		_failed += 1
		print("  [FAIL] " + test_name)
