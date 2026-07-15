extends Node
## SceneManager — scene transitions, per-zone world-state persistence, fade + title cards.
## Full spec: GDD §13. STUB (Phase 0). Full implementation is Phase 2.2.

signal scene_changing(to_path: String)
signal scene_changed(to_path: String)

var _current_zone_path: String = ""

## Change to a zone scene, optionally spawning the player at a named marker.
func change_zone(scene_path: String, spawn_point: String = "") -> void:
	# TODO Phase 2.2: fade out, persist current zone world-state, load target,
	# place player at spawn_point, fade in, emit signals.
	scene_changing.emit(scene_path)
	_current_zone_path = scene_path
	GameState.current_scene = scene_path
	var err := get_tree().change_scene_to_file(scene_path)
	if err == OK:
		scene_changed.emit(scene_path)
	else:
		push_error("SceneManager.change_zone failed for %s (err %d)" % [scene_path, err])
