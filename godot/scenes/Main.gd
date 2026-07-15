extends Control
## Bootstrap / smoke-test scene for KAYOS: The Night of Silence.
## Phase 0: proves the project runs at 640x360 and that the GameState flag registry
## + save/load round-trip works. Replaced by the real main menu (UI-011) later.

@onready var status: Label = $VBox/Status


func _ready() -> void:
	var lines: Array[String] = []
	lines.append("Engine: " + Engine.get_version_info().string)
	lines.append("Viewport: %d x %d" % [
		get_viewport().get_visible_rect().size.x,
		get_viewport().get_visible_rect().size.y])
	lines.append("Registry flags seeded: %d" % GameState.flags.size())

	# --- Legacy System smoke test: write -> save -> mutate -> load -> verify ---
	GameState.set_flag("P1_WARD_SCHEME", "LATTICE")
	GameState.bump_flag("P1_COIL_LOYALTY", 2, 0, 3)
	GameState.save_game()
	GameState.set_flag("P1_WARD_SCHEME", "SEAL")        # corrupt in memory
	var ok := GameState.load_game()                     # should restore LATTICE
	var restored: bool = ok \
		and GameState.get_flag("P1_WARD_SCHEME") == "LATTICE" \
		and int(GameState.get_flag("P1_COIL_LOYALTY")) == 2
	lines.append("Save/load round-trip: %s" % ("PASS ✓" if restored else "FAIL ✗"))

	status.text = "\n".join(lines)
	print("[KAYOS bootstrap]\n" + status.text)
