extends Node
## Headless proof of the Phase 2 interaction wiring (synchronous — no physics-frame await).
## Confirms an NPC configures itself from CharacterData and that interacting drives the same
## dialogue engine proven in Phase 1. (The Area2D proximity detection is standard Godot behaviour,
## verified by walking up to Corel in-editor.)

var _passed := 0
var _failed := 0


func _ready() -> void:
	var npc: NPC = preload("res://actors/NPC.tscn").instantiate()
	npc.character_data = preload("res://data/characters/corel.tres")
	add_child(npc)                                 # triggers NPC._ready configuration

	_check(npc.display_name == "Corel", "NPC pulled display_name from CharacterData")
	_check(npc.dialogue.ends_with("mq01_corel_briefing.json") or npc.dialogue.ends_with("test_funding_lie.json"),
		"NPC pulled dialogue from CharacterData")

	GameState.flags.clear()
	GameState._seed_default_flags()
	npc.interact()
	_check(DialogueManager.is_active(), "interacting with Corel starts the conversation")

	DialogueManager.choose(0)
	_check(GameState.get_flag("P1_FUNDING") == "TRUTH" or GameState.get_quest_state("mq01_containment_problem") == "active",
		"choosing through the in-world conversation writes Legacy flags")

	var board := Interactable.new()
	board.display_name = "Notice Board"
	board.examine_text = "A notice, circled twice."
	add_child(board)
	board.interact()
	_check(DialogueManager.is_active(), "examine-only Interactable opens a one-line exchange")

	print("\n==== Interaction test: %d passed, %d failed ====" % [_passed, _failed])
	get_tree().quit(0 if _failed == 0 else 1)


func _check(cond: bool, name: String) -> void:
	if cond:
		_passed += 1
		print("  [PASS] " + name)
	else:
		_failed += 1
		print("  [FAIL] " + name)
