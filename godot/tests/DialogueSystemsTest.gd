extends Node
## Headless assertion harness for Phase 1 core systems (CP-1 proof).
## Drives DialogueManager + CheckResolver + Strain + the flag registry through the §8.2
## "Funding Lie" tree and asserts behaviour. Run:
##   Godot_4.7 --headless --path godot res://tests/DialogueSystemsTest.tscn
## Exits 0 if all pass, 1 otherwise.

const CONV := "res://data/dialogue/test_funding_lie.json"

var _last_choices: Array = []
var _last_node: Dictionary = {}
var _silence_fired := false
var _passed := 0
var _failed := 0


func _ready() -> void:
	DialogueManager.node_entered.connect(func(n): _last_node = n)
	DialogueManager.choices_ready.connect(func(c): _last_choices = c)
	GameState.strain_silence_triggered.connect(func(): _silence_fired = true)

	_test_require_flag_hiding()
	_test_check_tag_states()
	_test_choose_lie_sets_flag_and_strain()
	_test_goto_fail_on_failed_check()
	_test_pass_routes_to_goto()
	_test_ledger_save_reload()
	_test_strain_bands_and_silence()
	_test_strain_gates_options()

	print("\n==== Phase 1 systems test: %d passed, %d failed ====" % [_passed, _failed])
	get_tree().quit(0 if _failed == 0 else 1)


## --- helpers -----------------------------------------------------------------
func _check(cond: bool, name: String) -> void:
	if cond:
		_passed += 1
		print("  [PASS] " + name)
	else:
		_failed += 1
		print("  [FAIL] " + name)

func _reset() -> void:
	GameState.flags.clear()
	GameState._seed_default_flags()
	GameState.mental_strain = 0
	for a in GameState.ATTRIBUTES:
		GameState.attributes[a] = 3
	_last_choices = []
	_last_node = {}

func _choice_with_check() -> Dictionary:
	for c in _last_choices:
		if c.get("check") != null:
			return c
	return {}


## --- tests -------------------------------------------------------------------
func _test_require_flag_hiding() -> void:
	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")   # not harmonist
	DialogueManager.start(CONV)
	_check(_last_choices.size() == 3, "require_flag hides class-gated option (3 visible for non-harmonist)")

	_reset()
	GameState.set_flag("P1_CLASS", "harmonist")
	DialogueManager.start(CONV)
	_check(_last_choices.size() == 4, "require_flag reveals class-gated option (4 visible for harmonist)")

func _test_check_tag_states() -> void:
	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")
	GameState.set_attribute("Acumen", 3)           # below DC 7
	DialogueManager.start(CONV)
	var c := _choice_with_check()
	_check(c.get("state") == "locked" and c.get("enabled") == false,
		"failed check is shown-but-LOCKED (Acumen 3 vs DC 7)")

	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")
	GameState.set_attribute("Acumen", 7)           # meets DC 7
	DialogueManager.start(CONV)
	c = _choice_with_check()
	_check(c.get("state") == "passable" and c.get("enabled") == true,
		"passable check shows PASSABLE (Acumen 7 vs DC 7)")

func _test_choose_lie_sets_flag_and_strain() -> void:
	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")
	DialogueManager.start(CONV)
	DialogueManager.choose(1)                       # the lie
	_check(GameState.get_flag("P1_FUNDING") == "LIE", "choosing the lie sets P1_FUNDING=LIE")
	_check(GameState.mental_strain == 8, "entering the lie node applies +8 Strain")

func _test_goto_fail_on_failed_check() -> void:
	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")
	GameState.set_attribute("Acumen", 3)           # will fail DC 7
	DialogueManager.start(CONV)
	DialogueManager.choose(2)                       # the Acumen option -> fail -> goto_fail
	_check(String(_last_node.get("text", "")).begins_with("A pretty phrase"),
		"failed check routes to goto_fail (hedge_fail), never a dead stop")

func _test_pass_routes_to_goto() -> void:
	_reset()
	GameState.set_flag("P1_CLASS", "voidweaver")
	GameState.set_attribute("Acumen", 7)           # passes DC 7
	DialogueManager.start(CONV)
	DialogueManager.choose(2)
	_check(GameState.get_flag("P1_FUNDING") == "HEDGE",
		"passed check routes to goto (hedge_check) and sets P1_FUNDING=HEDGE")

func _test_ledger_save_reload() -> void:
	_reset()
	GameState.set_flag("P1_WARD_SCHEME", "ORBIT")
	GameState.bump_flag("P1_DURAK_TRUST", 3, 0, 3)
	GameState.set_attribute("Arcana", 8)
	GameState.save_game()
	GameState.set_flag("P1_WARD_SCHEME", "SEAL")    # corrupt in memory
	GameState.set_attribute("Arcana", 1)
	var ok := GameState.load_game()
	_check(ok and GameState.get_flag("P1_WARD_SCHEME") == "ORBIT",
		"Legacy flag survives save -> reload (P1->P2 harness)")
	_check(int(GameState.get_flag("P1_DURAK_TRUST")) == 3, "int flag survives save/reload")
	_check(GameState.get_attribute("Arcana") == 8, "attributes survive save/reload")

func _test_strain_bands_and_silence() -> void:
	_reset()
	_silence_fired = false
	GameState.add_strain(30)
	_check(GameState.get_strain_band() == GameState.StrainBand.FRAYED, "Strain 30 -> FRAYED band")
	GameState.add_strain(45)                        # 75
	_check(GameState.get_strain_band() == GameState.StrainBand.BREAKING, "Strain 75 -> BREAKING band")
	GameState.add_strain(40)                        # -> 100, Silence fires, resets to 60
	_check(_silence_fired, "Strain hitting 100 fires the Silence scene")
	_check(GameState.mental_strain == 60, "Silence resets Strain to 60 (never a game-over)")

func _test_strain_gates_options() -> void:
	# A tiny inline conversation: one composed option (hidden past Frayed) + one desperate
	# option (revealed only at/above Breaking). GDD §7.3.
	var conv := {
		"id": "strain_gate", "start": "n",
		"nodes": { "n": { "speaker": "elorin", "text": "...", "choices": [
			{ "text": "A composed, patient reply.", "max_band": GameState.StrainBand.FRAYED, "goto": "" },
			{ "text": "A raw, desperate outburst.", "min_band": GameState.StrainBand.BREAKING, "goto": "" },
		] } }
	}
	_reset()                                    # Strain 0 -> Calm
	DialogueManager.start(conv)
	_check(_last_choices.size() == 1 and _last_choices[0]["text"].begins_with("A composed"),
		"at Calm: composed option shown, desperate option hidden")

	_reset()
	GameState.mental_strain = 80                # Breaking band
	DialogueManager.start(conv)
	_check(_last_choices.size() == 1 and _last_choices[0]["text"].begins_with("A raw"),
		"at Breaking: composed option gone, desperate option unlocked")
