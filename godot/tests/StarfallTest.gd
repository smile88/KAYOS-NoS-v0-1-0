extends Node
## Headless proof of the walkable Starfall city greybox (godot/threed/StarfallCity3D). Asserts the
## load-bearing claims from docs/SESSION_HANDOFF.md: the player spawns grounded on the rim, descends the
## terraces under gravity without falling through, the star-lake "Mirror" is a real void that fishes you
## back onto solid ground, and the zone is wired for the Cold Open handoff (a "player"-group body + a
## SpawnFromColdOpen marker). Also censuses the scene so the performance budget is a tracked number, not
## a vibe.
##
## Physics needs real ticks, so this drives Input.action_press and waits on get_tree().physics_frame
## (a modest Engine.time_scale stretches world time per tick without tunnelling the 1 m ramp colliders).

const SCENE := "res://threed/StarfallCity3D.tscn"
const TIME_SCALE := 4.0
const Y_RIM := 45.6

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
		_check(absf(marker.global_position.y - Y_RIM) < 2.0 and marker.global_position.z > 380.0,
			"the spawn marker sits on the rim, front (+Z), where the player drops in")

	# --- census: the perf budget as a tracked number ---------------------------
	var census := {}
	_census(scene, census)
	var total := _count_all(scene)
	print("  [INFO] Starfall node census — total=%d  MeshInstance3D=%d  MultiMeshInstance3D=%d  StaticBody3D=%d  OmniLight3D=%d" % [
		total, census.get("MeshInstance3D", 0), census.get("MultiMeshInstance3D", 0),
		census.get("StaticBody3D", 0), census.get("OmniLight3D", 0)])
	_check(census.get("MeshInstance3D", 0) < 1800,
		"visible-mesh node count is within the perf budget (<1800 MeshInstance3D)")

	# --- grounded on the rim, no fall-through ----------------------------------
	await _physics(30)
	_check(player.is_on_floor(), "the player settles grounded on the rim (doesn't fall through the terrace)")
	_check(absf(player.global_position.y - Y_RIM) < 2.5,
		"the player rests at rim height (~%.1f m), not sunk into or floating above it" % Y_RIM)

	# --- walk inward and DOWN the terraces (the marquee walkability claim) ------
	var start_y := player.global_position.y
	Input.action_press("move_up")               # -Z = inward, toward the caldera / down the stairs
	var min_y := player.global_position.y
	for i in range(200):
		await get_tree().physics_frame
		min_y = minf(min_y, player.global_position.y)
	Input.action_release("move_up")
	_check(player.global_position.y < start_y - 8.0,
		"walking inward descends the terraces (dropped %.1f m from the rim)" % (start_y - player.global_position.y))
	_check(min_y > -30.0, "the descent never fell through the world into the void (min y = %.1f)" % min_y)
	await _physics(20)
	_check(player.is_on_floor(), "the player is still grounded after the descent")

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

	# --- the Open House: a real enterable interior (item 6, first slice) --------
	var lectern := _find_examinable(scene, "The Astronomer's Lectern")
	_check(lectern != null, "the Open House has an examinable lectern inside it")

	# The interior floor holds: drop the player in from below the ceiling and it lands on the room floor.
	# Room centre is world (30, 34, 372); interior spans y≈34.3 (floor) to ≈39.75 (ceiling).
	player.global_position = Vector3(30.0, 38.0, 372.0)
	player.velocity = Vector3.ZERO
	await _physics(40)
	_check(player.is_on_floor() and player.global_position.y > 33.5 and player.global_position.y < 35.0,
		"the Open House interior floor is solid — the player stands inside it (y=%.1f)" % player.global_position.y)

	# The doorway is a real opening, not a painted-on door: a ray across the door gap passes through,
	# while the SAME ray offset onto the adjacent front-wall segment is blocked.
	var space := get_tree().root.world_3d.direct_space_state
	var gap := space.intersect_ray(PhysicsRayQueryParameters3D.create(
		Vector3(21.0, 35.0, 372.0), Vector3(27.0, 35.0, 372.0)))   # z=372 = door centre
	var solid := space.intersect_ray(PhysicsRayQueryParameters3D.create(
		Vector3(21.0, 35.0, 376.15), Vector3(27.0, 35.0, 376.15))) # z=376.15 = front-wall segment
	_check(gap.is_empty(), "the doorway is an actual gap you can walk through (ray passes clean)")
	_check(not solid.is_empty(), "the wall beside the doorway is solid (control ray is blocked)")

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
