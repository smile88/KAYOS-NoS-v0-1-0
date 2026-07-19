extends Node3D
class_name ColdOpen3D
## Cold Open director for the HD-2D 3D build — "The Same Night" (GDD §4.1). Talindir on the night of
## the two-thousandth Luminarae, 2000 AO. A faithful port of scenes/zones/ColdOpen.gd: same clock,
## same beats, same one choice brought to the player, same Silence. Only the presentation changed.
##
## Design note that constrains everything below (unchanged from 2D): **the player cannot cause or
## prevent anything tonight.** Talindir has known for three hundred years and is here anyway. The
## scene runs on the festival's clock, not on the player's progress — the ninth bell comes whether
## they examined everything or nothing. Nothing is gated; there is no checklist. That powerlessness
## is the thesis. The one choice, COLDOPEN_HONEST, comes to the player: the festival-goer walks over
## and asks. She is not a marker to be hunted down.
##
## Room changes are delegated to the RoomCoordinator3D (it owns the fade + player move + camera
## retarget). The director sets its `auto = false` and drives go_to_room() itself so it can pause the
## festival clock while a change runs and speak the first descent/ascent line.

const FG_MAIN_DIALOGUE := "res://data/dialogue/coldopen_festivalgoer.json"
const SILENCE_DIALOGUE := "res://data/dialogue/coldopen_silence.json"
const STARFALL_ZONE := "res://scenes/zones/StarfallAcademy.tscn"

## The festival's clock, in seconds from taking control. Holds during dialogue and room changes, so
## it counts only time spent *not* reading. Same numbers as 2D (SILENCE_AT is the softest guess).
const FG_APPROACHES_AT := 55.0
const SILENCE_AT := 190.0

## Talindir's interiority, surfaced non-modally through the whisper label so it never interrupts
## exploration — the player should *feel* the bell coming without a HUD counting it down. Texts and
## timings verbatim from the 2D director.
const BEATS := [
	{ "t": 7.0, "text": "Talindir. Sixty years a scribe of the Astral Archive below you — and sixty Luminarae watched from this balcony, never once from down there among them." },
	{ "t": 26.0, "text": "Below, they have begun the count to the ninth bell." },
	{ "t": 88.0, "text": "The garlands draw brighter. The Song is being gathered up — the way breath is gathered before a shout." },
	{ "t": 150.0, "text": "The count is nearly done. On the Tower, a small figure raises his arms." },
]

const CONTROL_PROMPT := "WASD walk    ·    drag / Q E look    ·    F examine    ·    V first-person"
const FIRST_DESCENT := "Observation is not the same as absence, you have told yourself. You have been telling yourself that for sixty years."
const FIRST_ASCENT := "The noise comes back all at once, the way it does when you have been reading."

## Where she goes afterwards — over by the Celebrant and the Functionary, i.e. other people. Mapped
## from the 2D CROWD_SPOT (1020, 520).
const CROWD_SPOT := Vector3(5.3, 0.0, 0.0)

const FG_SPEED := 1.6
const FG_STOP_DIST := 1.0

## How much the world dims once the Song stops.
const MUTED_MOON_ENERGY := 0.12
const MUTED_AMBIENT_ENERGY := 0.25

@onready var whisper: Label = %Whisper
@onready var story_panel: CanvasLayer = %StoryPanel
@onready var player: Node3D = $Player3D
@onready var rig: CameraRig3D = $Camera3D
@onready var coord: RoomCoordinator3D = $RoomCoordinator
@onready var balcony: Balcony3D = $World
@onready var scriptorium: Scriptorium3D = $Scriptorium
@onready var moonlight: DirectionalLight3D = $MoonLight
@onready var world_env: WorldEnvironment = $WorldEnvironment

var _elapsed := 0.0
var _next_beat := 0
var _approaching := false
var _fg_spoke := false
var _silence_started := false
var _moving := false
var _festival_goer: NPC3D
var _whisper_tween: Tween


func _ready() -> void:
	GameState.current_protagonist = "talindir"
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

	# The coordinator owns the mechanical room change; we drive it so we can pause the clock and speak.
	coord.auto = false
	for node in get_tree().get_nodes_in_group("room_stair"):
		var stair := node as RoomStair3D
		if stair and not stair.used.is_connected(_on_stair_used):
			stair.used.connect(_on_stair_used)

	_festival_goer = get_tree().get_first_node_in_group("festival_goer") as NPC3D

	whisper.modulate.a = 0.0
	_say(CONTROL_PROMPT, 6.0)


func _process(delta: float) -> void:
	# The festival's clock holds while a conversation is open or a room change is running, so a slow
	# reader never has the night arrive on top of them mid-sentence.
	if DialogueManager.is_active() or _moving:
		return
	_elapsed += delta

	if _next_beat < BEATS.size() and _elapsed >= BEATS[_next_beat]["t"]:
		_say(BEATS[_next_beat]["text"], 5.0)
		_next_beat += 1

	# She can only come to the player on the balcony; if they're downstairs at the bell, she waits.
	if not _fg_spoke and not _approaching and _elapsed >= FG_APPROACHES_AT and coord.current_room == "balcony":
		_approaching = true
	if _approaching:
		if coord.current_room == "balcony":
			_walk_festival_goer(delta)
		else:
			_approaching = false

	if not _silence_started and _elapsed >= SILENCE_AT:
		_silence_started = true
		_run_silence()


## --- rooms (delegated to the coordinator) -------------------------------------
func _on_stair_used(stair: RoomStair3D) -> void:
	if _moving:
		return
	var first: bool = not GameState.get_flag("COLDOPEN_USED_STAIR", false)
	_moving = true
	await coord.go_to_room(stair.target_room)
	_moving = false
	GameState.set_flag("COLDOPEN_USED_STAIR", true)
	if first:
		_say(FIRST_DESCENT if stair.target_room == "scriptorium" else FIRST_ASCENT, 5.0)


## --- the one choice, brought to the player ------------------------------------
func _walk_festival_goer(delta: float) -> void:
	if _festival_goer == null:
		_approaching = false
		return
	var to := player.global_position - _festival_goer.global_position
	to.y = 0.0
	if to.length() <= FG_STOP_DIST:
		_approaching = false
		_fg_spoke = true
		_festival_goer.stop_walking()
		_festival_goer.dialogue = FG_MAIN_DIALOGUE
		_festival_goer.interact()
		return
	var dir := to.normalized()
	_festival_goer.walk_toward(dir)
	_festival_goer.global_position += dir * FG_SPEED * delta


func _on_dialogue_finished(id: String) -> void:
	if id == "coldopen_festivalgoer":
		_leave_into_the_crowd()


## Both branches end with her walking off. She walks to where the others are and *stays there*: a
## person at a party, not a quest-giver being garbage-collected. Clearing her dialogue stops the
## player reopening the exchange and flipping COLDOPEN_HONEST, which has to stay the answer they
## actually gave; the line she leaves behind depends on which answer that was.
func _leave_into_the_crowd() -> void:
	if _festival_goer == null:
		return
	var honest: bool = GameState.get_flag("COLDOPEN_HONEST", false)
	_festival_goer.dialogue = ""
	_festival_goer.examine_text = (
		"She is standing with her friends again. She is not laughing, and every little while she looks up at the sky, and then at you."
		if honest else
		"She is dancing again, and has already forgotten you entirely, which is precisely what you asked her to do."
	)
	_festival_goer.walk_toward(CROWD_SPOT - _festival_goer.global_position)
	var tw := create_tween()
	tw.tween_property(_festival_goer, "global_position", CROWD_SPOT, 3.4).set_trans(Tween.TRANS_SINE)
	tw.tween_callback(_festival_goer.stop_walking)


## --- the whisper (the old hint HUD, repurposed; never a quest tracker) ---------
func _say(text: String, hold: float) -> void:
	if _whisper_tween and _whisper_tween.is_valid():
		_whisper_tween.kill()
	whisper.text = text
	_whisper_tween = create_tween()
	_whisper_tween.tween_property(whisper, "modulate:a", 1.0, 0.8)
	_whisper_tween.tween_interval(hold)
	_whisper_tween.tween_property(whisper, "modulate:a", 0.0, 1.2)


## --- Beat 4 — the Night of Silence, seen from the balcony and not understood ---
func _run_silence() -> void:
	if _whisper_tween and _whisper_tween.is_valid():
		_whisper_tween.kill()
	whisper.modulate.a = 0.0

	# If he's downstairs when it happens, the room tells him first and he climbs. The bell does not
	# wait for the player to be standing somewhere convenient.
	if coord.current_room != "balcony":
		scriptorium.drain_to_dark(1.2)
		_say("The lamp goes out. Every lamp goes out. Above you, through the stairwell, the gold on the wall drains away to nothing.", 4.0)
		await get_tree().create_timer(4.6).timeout
		_moving = true
		await coord.go_to_room("balcony")
		_moving = false

	await get_tree().create_timer(1.4).timeout

	# Everyone stops at once, then goes to the rail — because that is what people do. Talindir does
	# NOT rush: he is the only one who already knows. The player keeps control.
	var rail := Vector3(0.0, 0.0, Balcony3D.RAIL_Z)
	for w in get_tree().get_nodes_in_group("wanderer3d"):
		(w as Wanderer3D).rush_to(rail, 2.2)

	# The Song stops: the city, the Tower and the festival lamps drain to dark, and the whole world
	# goes muted and cold.
	balcony.drain_to_dark(2.6, 0.03)   # small per-light stagger = the ring of quiet spreading out
	var tw := create_tween().set_parallel(true)
	tw.tween_property(moonlight, "light_energy", MUTED_MOON_ENERGY, 3.0)
	var env := world_env.environment
	if env:
		tw.tween_property(env, "ambient_light_energy", MUTED_AMBIENT_ENERGY, 3.0)
	await tw.finished

	DialogueManager.start(SILENCE_DIALOGUE)
	while true:
		var finished_id: String = await DialogueManager.dialogue_finished
		if finished_id == "coldopen_silence":
			break

	# VS-001 story panel, then hard cut to the Part One title card.
	story_panel.visible = true
	await get_tree().create_timer(2.6).timeout

	GameState.set_flag("COLDOPEN_DONE", true)
	GameState.current_protagonist = "elorin"
	GameState.save_game()
	SceneManager.change_zone(STARFALL_ZONE, "SpawnFromColdOpen",
		"PART ONE — THE ARCHITECT", "Starfall · the Academy of Astral Harmony · c. 1450 AO")
