extends Node
## Headless proof of the HD-2D 3D Cold Open — "The Same Night" (GDD §4.1). The 3D twin of
## ColdOpenTest.gd, and it makes the same load-bearing assertion: **nothing is gated.** The
## festival-goer comes over and the Silence arrives on the festival's own clock, with the telescope
## and the satchel never touched, and the whole night still hands off to Starfall.
##
## Engine.time_scale compresses the festival's clock; the director reads scaled delta.

const SCENE := "res://threed/ColdOpen3D.tscn"
const TIME_SCALE := 50.0
const TIMEOUT_MS := 40000

var _passed := 0
var _failed := 0
var _last_started_id := ""
var _last_node_text := ""
var _changed_to := ""


func _ready() -> void:
	Engine.time_scale = TIME_SCALE
	DialogueManager.dialogue_started.connect(func(id: String): _last_started_id = id)
	DialogueManager.node_entered.connect(func(n: Dictionary): _last_node_text = String(n.get("text", "")))
	SceneManager.scene_changing.connect(func(p: String): _changed_to = p)
	GameState.reset()

	DirAccess.remove_absolute(GameState.SAVE_PATH)
	_check(not FileAccess.file_exists(GameState.SAVE_PATH), "no stale autosave carried into the run")

	# Park the protagonist somewhere wrong first — GameState.reset() already sets "talindir", so
	# asserting it straight after reset would pass whether or not the director ever ran.
	GameState.current_protagonist = "nobody"

	var dir: ColdOpen3D = (load(SCENE) as PackedScene).instantiate()
	add_child(dir)
	await get_tree().process_frame
	await get_tree().process_frame

	_check(GameState.current_protagonist == "talindir", "the Cold Open sets protagonist to Talindir")

	var coord: RoomCoordinator3D = dir.get_node("RoomCoordinator")
	var player: Node3D = dir.get_node("Player3D")

	var fg: NPC3D = get_tree().get_first_node_in_group("festival_goer")
	_check(fg != null and fg.dialogue.ends_with("coldopen_festivalgoer_early.json"),
		"the festival-goer opens with the early festival line")

	# Density (GDD pillar 4 / §8.4): both rooms have to reward wandering, almost none of it gated.
	var examinables := get_tree().get_nodes_in_group("interactable3d").size()
	_check(examinables >= 24, "the two rooms reward wandering (%d examinable nodes)" % examinables)

	# It is the biggest festival in two thousand years. The balcony is not allowed to hold two people.
	var crowd := get_tree().get_nodes_in_group("wanderer3d")
	_check(crowd.size() >= 6, "the balcony is populated (%d wandering NPCs)" % crowd.size())
	for w in crowd:
		if (w as Wanderer3D).examine_text == "":
			_failed += 1
			print("  [FAIL] crowd NPC %s has nothing to say" % w.name)
			break

	# The crowd are 3D models that turn to face their heading (no billboard, no quantised diagonal):
	# walk_toward() sets it moving and rotates it to the movement direction; stop_walking() halts it.
	var sample := crowd[0] as Wanderer3D
	_check(sample.model is CharacterModel3D, "crowd NPCs are 3D hooded-figure models")
	sample.walk_toward(Vector3(1, 0, 0))
	_check(sample.model._moving, "walk_toward() sets the figure moving")
	_check(absf(sample.model.rotation.y - atan2(1.0, 0.0)) < 0.01,
		"walk_toward() turns the figure to face its heading (not the camera)")
	sample.stop_walking()
	_check(not sample.model._moving, "stop_walking() halts it")

	# The scriptorium is real and reachable, not set dressing behind a locked door.
	_stair_to("scriptorium").interact()
	await _settle(dir)
	_check(player.global_position.y < -20.0,
		"the stair down actually goes somewhere — the player dropped into the scriptorium")
	_check(coord.current_room == "scriptorium" and dir.rig.floor_min_y < -1.0,
		"the camera retargets to the scriptorium as its own room")
	var cabinet := _find_examinable("The Locked Cabinet")
	cabinet.interact()
	_check(DialogueManager.is_active()
		and _last_node_text.begins_with("Indigo lacquer")
		and _last_node_text == cabinet.examine_text,
		"scriptorium objects are examinable — the locked cabinet shows its own text")
	DialogueManager.advance()
	_stair_to("balcony").interact()
	await _settle(dir)
	_check(player.global_position.y > -20.0, "the stair up returns to the balcony")

	# Examine exactly one object — the banner — and leave the telescope and satchel alone.
	var banner := _find_examinable("Festival Banner")
	banner.interact()
	DialogueManager.advance()
	_check(GameState.get_flag("COLDOPEN_SAW_BANNER") == true, "examining sets its flag")
	_check(not GameState.get_flag("COLDOPEN_SAW_TELESCOPE", false)
		and not GameState.get_flag("COLDOPEN_SAW_LETTER", false),
		"telescope and satchel deliberately left untouched for the rest of this run")

	# Beat 3 — she comes to the player. Nothing was completed to earn this.
	await _await_dialogue("coldopen_festivalgoer")
	_check(_last_started_id == "coldopen_festivalgoer",
		"the festival-goer approaches unprompted, with the checklist unfinished")
	DialogueManager.choose(0)                      # "Tonight something ends."
	_check(GameState.get_flag("COLDOPEN_HONEST") == true, "telling the truth sets COLDOPEN_HONEST")
	DialogueManager.choose(0)
	DialogueManager.advance()
	await get_tree().process_frame
	_check(fg.dialogue == "", "she leaves into the crowd — the one choice cannot be retaken")

	# Beat 4 — the night arrives on its own schedule regardless of the player.
	await _await_dialogue("coldopen_silence")
	_check(_last_started_id == "coldopen_silence",
		"the Silence arrives on the festival's clock, not on player progress")
	DialogueManager.choose(0)
	DialogueManager.choose(0)
	DialogueManager.advance()

	var deadline := Time.get_ticks_msec() + TIMEOUT_MS
	while _changed_to == "" and Time.get_ticks_msec() < deadline:
		await get_tree().process_frame
	_check(_changed_to.ends_with("StarfallAcademy.tscn"), "the Cold Open hands off to Starfall Academy")
	_check(GameState.get_flag("COLDOPEN_DONE") == true, "COLDOPEN_DONE written")
	_check(GameState.current_protagonist == "elorin", "protagonist handoff to Elorin")
	_check(FileAccess.file_exists(GameState.SAVE_PATH), "autosave written at the handoff")

	print("\n==== Cold Open 3D test: %d passed, %d failed ====" % [_passed, _failed])
	get_tree().quit(0 if _failed == 0 else 1)


func _stair_to(room: String) -> RoomStair3D:
	for n in get_tree().get_nodes_in_group("room_stair"):
		var st := n as RoomStair3D
		if st and st.target_room == room:
			return st
	return null


func _find_examinable(display_name: String) -> Interactable3D:
	for n in get_tree().get_nodes_in_group("interactable3d"):
		var it := n as Interactable3D
		if it and it.display_name == display_name:
			return it
	return null


func _await_dialogue(id: String) -> void:
	var deadline := Time.get_ticks_msec() + TIMEOUT_MS
	while _last_started_id != id and Time.get_ticks_msec() < deadline:
		await get_tree().process_frame


## Wait out a room change (the coordinator's two fades plus a frame), whatever the time scale.
func _settle(dir: ColdOpen3D) -> void:
	var deadline := Time.get_ticks_msec() + 5000
	while dir._moving and Time.get_ticks_msec() < deadline:
		await get_tree().process_frame
	await get_tree().process_frame


func _check(cond: bool, name: String) -> void:
	if cond:
		_passed += 1
		print("  [PASS] " + name)
	else:
		_failed += 1
		print("  [FAIL] " + name)
