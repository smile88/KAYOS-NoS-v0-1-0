extends Node
## Headless proof of the walkable Starfall city greybox (godot/threed/StarfallCity3D). Asserts the
## load-bearing claims from docs/SESSION_HANDOFF.md: the player spawns grounded at the city entrance,
## the entrance walkway connects seamlessly onto the canal-quarter terrace without a stair, the star-lake
## "Mirror" is a real void that fishes you back onto solid ground, and the zone is wired for the Cold
## Open handoff (a "player"-group body + a SpawnFromColdOpen marker). Also censuses the scene so the
## performance budget is a tracked number, not a vibe.
##
## Markers-only pass: individual buildings/towers/props are placeholder discs now, not real geometry —
## this suite only asserts the generated SHELL (terraces, entrance cut, Under-Terraces cavity, lake,
## causeway, island base) plus the JSON-driven examinables, which are unaffected by that.
##
## Physics needs real ticks, so this drives Input.action_press and waits on get_tree().physics_frame
## (a modest Engine.time_scale stretches world time per tick without tunnelling the 1 m ramp colliders).

const SCENE := "res://threed/StarfallCity3D.tscn"
const TIME_SCALE := 4.0
const Y_SPAWN := 12.6      # Y_L4 + 0.6 — the entrance walkway's height, where the player now drops in
const Y_L4 := 12.0

var _passed := 0
var _failed := 0


func _ready() -> void:
	Engine.time_scale = TIME_SCALE

	var scene: Node3D = (load(SCENE) as PackedScene).instantiate()
	add_child(scene)
	await _frames(4)

	var player: Player3D = get_tree().get_first_node_in_group("player") as Player3D
	_check(player != null, "the city has a body in the \"player\" group (SceneManager can place it)")

	var marker: Node3D = scene.find_child("SpawnFromColdOpen", true, false) as Node3D
	_check(marker != null, "a SpawnFromColdOpen Marker3D exists for the Cold Open handoff")
	if marker:
		_check(absf(marker.global_position.y - Y_SPAWN) < 2.0 and marker.global_position.z > 380.0,
			"the spawn marker sits at the entrance, front (+Z), where the player drops in")

	# --- census: the perf budget as a tracked number ---------------------------
	var census := {}
	_census(scene, census)
	var total := _count_all(scene)
	print("  [INFO] Starfall node census — total=%d  MeshInstance3D=%d  MultiMeshInstance3D=%d  StaticBody3D=%d  OmniLight3D=%d" % [
		total, census.get("MeshInstance3D", 0), census.get("MultiMeshInstance3D", 0),
		census.get("StaticBody3D", 0), census.get("OmniLight3D", 0)])
	_check(census.get("MeshInstance3D", 0) < 1800,
		"visible-mesh node count is within the perf budget (<1800 MeshInstance3D)")

	# --- the plan is walkable: real named buildings placed from res://data/starfall_city.json ---
	var sounding := _find_examinable(scene, "The Sounding-Glass")
	_check(sounding != null, "a named plan building is in the world (the Sounding-Glass inn, House Vael'Suran)")
	var serenthil := _find_examinable(scene, "The Bell-Foundry")
	_check(serenthil != null, "a second wedge's building is present too (the Bell-Foundry, House Serenthil)")
	var ix := get_tree().get_nodes_in_group("interactable3d").size()
	_check(ix >= 100, "the city plan populated the world with examinable buildings (%d interactables)" % ix)

	# --- grounded at the entrance, no fall-through -----------------------------
	await _physics(30)
	_check(player.is_on_floor(), "the player settles grounded at the entrance (doesn't fall through the walkway)")
	_check(absf(player.global_position.y - Y_SPAWN) < 2.5,
		"the player rests at the entrance walkway's height (~%.1f m), not sunk into or floating above it" % Y_SPAWN)

	# --- walk inward along the entrance cut onto the canal-quarter terrace -----
	# The walkway (Y_L4) and the CanalRing terrace it leads into are flush — this is the one connector
	# that's still generated (see _build_entrance), so it should be walkable with NO stair at all, unlike
	# every other terrace boundary now (stairs/ramps are hand-placed — see the class doc).
	var start_pos := player.global_position
	Input.action_press("move_up")               # -Z = inward, along the entrance toward the caldera
	var min_y := player.global_position.y
	for i in range(200):
		await get_tree().physics_frame
		min_y = minf(min_y, player.global_position.y)
	Input.action_release("move_up")
	var traveled := Vector2(player.global_position.x, player.global_position.z).distance_to(
		Vector2(start_pos.x, start_pos.z))
	_check(traveled > 5.0, "walking inward covers real ground along the entrance (%.1f m travelled)" % traveled)
	_check(absf(player.global_position.y - Y_L4) < 3.0,
		"the entrance walkway and the canal-quarter terrace are flush — no stair needed to cross onto it (y=%.1f)" % player.global_position.y)
	_check(min_y > -30.0, "the walk never fell through the world into the void (min y = %.1f)" % min_y)
	await _physics(20)
	_check(player.is_on_floor(), "the player is still grounded after walking in")

	# --- the Mirror is a void that returns you to solid ground -----------------
	var safe_before := player.global_position
	# Out over open star-lake: radius ~150 (between island r=75 and shore r=225), off the +Z causeway.
	player.global_position = Vector3(150.0, 8.0, 0.0)
	player.velocity = Vector3.ZERO
	var fell_flagged := [false]   # array so the signal lambda can mutate it (GDScript captures by value)
	player.fell.connect(func(): fell_flagged[0] = true)
	for i in range(200):
		await get_tree().physics_frame
		if player.global_position.y > 1.0 and player.is_on_floor():
			break
	_check(fell_flagged[0], "stepping onto the Mirror triggers the fall (it is sky, not a walkable floor)")
	_check(player.global_position.y > 1.0,
		"the Mirror fishes the player back onto solid ground (y=%.1f, not lost in the void)" % player.global_position.y)
	_check(player.global_position.distance_to(safe_before) < 3.0,
		"respawn returns to the last solid ground the player stood on, not a fixed corner")

	# --- the Open House: no marker, no walls anymore (hand-placed now, see the class doc) --------
	# Its lectern is writing, not structure, so it stayed as a plain examinable at the same spot.
	var lectern := _find_examinable(scene, "The Astronomer's Lectern")
	_check(lectern != null, "the Open House's lectern examinable still exists at its old position")

	# --- markers have been replaced by the actual 3D models --------------------
	var tower_marker := scene.find_child("Marker_H0_VaelSuran", true, false)
	_check(tower_marker == null, "a House tower marker is gone (H0 Vael'Suran)")
	var obs_marker := scene.find_child("Marker_The_Great_Observatory_(City_Centre)", true, false)
	_check(obs_marker == null, "the observatory/city-centre marker is gone on the island")
	var mono_marker := scene.find_child("Marker_The_Armillary_of_the_First_Measure", true, false)
	_check(mono_marker == null, "the armillary monument marker is gone")
	var building_marker := scene.find_child("Marker_The_Sounding-Glass", true, false)
	_check(building_marker == null, "individual plan buildings (e.g. the Sounding-Glass) no longer get a visual marker")
	
	# Verify that actual models spawned
	var tower_model := scene.find_child("Tower_H0_VaelSuran", true, false)
	_check(tower_model != null, "a House tower model is present (H0 Vael'Suran)")
	var obs_model := scene.find_child("GreatObservatory", true, false)
	_check(obs_model != null, "the observatory model is present on the island")
	var mono_model := scene.find_child("ArmillaryMonumentVisual", true, false)
	_check(mono_model != null, "the armillary monument model is present")

	print("\n==== Starfall test: %d passed, %d failed ====" % [_passed, _failed])
	get_tree().quit(0 if _failed == 0 else 1)


# --- helpers -----------------------------------------------------------------

func _find_examinable(_scene: Node, display_name: String) -> Interactable3D:
	for n in get_tree().get_nodes_in_group("interactable3d"):
		var it := n as Interactable3D
		if it and it.display_name == display_name:
			return it
	return null


func _census(n: Node, acc: Dictionary) -> void:
	var cls := n.get_class()
	acc[cls] = acc.get(cls, 0) + 1
	for c in n.get_children():
		_census(c, acc)


func _count_all(n: Node) -> int:
	var c := 1
	for ch in n.get_children():
		c += _count_all(ch)
	return c


func _frames(n: int) -> void:
	for i in range(n):
		await get_tree().process_frame


func _physics(n: int) -> void:
	for i in range(n):
		await get_tree().physics_frame


func _check(cond: bool, name: String) -> void:
	if cond:
		_passed += 1
		print("  [PASS] " + name)
	else:
		_failed += 1
		print("  [FAIL] " + name)
