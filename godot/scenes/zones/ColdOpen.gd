extends Node2D
## Cold Open director — "The Same Night" (GDD §4.1). Talindir on the night of the two-thousandth
## Luminarae, 2000 AO.
##
## Design note, because it constrains everything below: **the player cannot cause or prevent
## anything tonight.** Talindir has known for three hundred years and is here anyway, watching.
## So the scene runs on the festival's clock, not on the player's progress — the count reaches the
## ninth bell and the Song stops whether the player examined everything or nothing at all. Nothing
## is gated behind a checklist; there is no "0/3". That powerlessness *is* the thesis (GDD §4.1:
## "The player does not understand what they just saw. That is the point.")
##
## The one choice — COLDOPEN_HONEST — comes to the player: the festival-goer walks over and asks.
## She is not a quest marker to be hunted down.
##
## **Two rooms, one scene.** The balcony (y 0..720) and the scriptorium below it (y 720..1440) live
## in one .tscn rather than two zones, so a single director owns one clock and the Silence can find
## the player wherever they happen to be standing. Each room is exactly one 1280x720 screen; moving
## between them re-pins the player's Camera2D limits, so each reads as a fixed tableau and the whole
## room is visible at once (GDD §13: raise the native resolution, never zoom the camera out).

const FG_MAIN_DIALOGUE := "res://data/dialogue/coldopen_festivalgoer.json"
const SILENCE_DIALOGUE := "res://data/dialogue/coldopen_silence.json"
const STARFALL_ZONE := "res://scenes/zones/StarfallAcademy.tscn"

const ROOMS := {
	"balcony": { "limits": Rect2(0, 0, 1280, 720), "spawn": Vector2(180, 640) },
	"scriptorium": { "limits": Rect2(0, 720, 1280, 720), "spawn": Vector2(190, 1010) },
}

## The festival's clock, in seconds from the player taking control. Tuned so an unhurried player can
## read both rooms before the bell, while a player who reads nothing still waits out the same night.
## The clock holds during dialogue, so these count only time spent *not* reading. Tests compress
## them with Engine.time_scale.
const FG_APPROACHES_AT := 55.0
const SILENCE_AT := 190.0

## Talindir's interiority, surfaced non-modally so it never interrupts exploration. These carry the
## dread and telegraph the apex diegetically — the player should *feel* the bell coming without a
## HUD ever counting it down for them.
const BEATS := [
	{ "t": 26.0, "text": "Below, they have begun the count to the ninth bell." },
	{ "t": 88.0, "text": "The garlands draw brighter. The Song is being gathered up — the way breath is gathered before a shout." },
	{ "t": 150.0, "text": "The count is nearly done. On the Tower, a small figure raises his arms." },
]

const CONTROL_PROMPT := "WASD — walk        E — look"
const FIRST_DESCENT := "Observation is not the same as absence, you have told yourself. You have been telling yourself that for sixty years."
const FIRST_ASCENT := "The noise comes back all at once, the way it does when you have been reading."

const APPROACH_SPEED := 46.0
const APPROACH_STOP_DIST := 52.0

## How dark a silenced district goes, and how muted the world becomes after the Song stops.
const DISTRICT_DARK := Color(0.16, 0.16, 0.24)
const WORLD_MUTED := Color(0.52, 0.55, 0.72)

@onready var whisper: Label = %Hint
@onready var room_fade: ColorRect = %RoomFade
@onready var festival_goer: NPC = %FestivalGoer
@onready var city: Node2D = %CityBelow
@onready var festival_lights: Node2D = %FestivalLights
@onready var script_lights: Node2D = %ScriptLights
@onready var world_tint: CanvasModulate = $CanvasModulate
@onready var story_panel: CanvasLayer = $StoryPanel
@onready var player: Node2D = $World/Player
@onready var camera: Camera2D = $World/Player/Camera2D

var _room := "balcony"
var _elapsed := 0.0
var _next_beat := 0
var _approaching := false
var _fg_spoke := false
var _silence_started := false
var _moving := false
var _whisper_tween: Tween


func _ready() -> void:
	GameState.current_protagonist = "talindir"
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	for stair in [%StairDown, %StairUp]:
		(stair as RoomStair).used.connect(_on_stair_used)
	whisper.modulate.a = 0.0
	room_fade.color.a = 0.0
	_apply_room_limits("balcony")
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
	if not _fg_spoke and not _approaching and _elapsed >= FG_APPROACHES_AT and _room == "balcony":
		_approaching = true
	if _approaching:
		if _room == "balcony":
			_walk_festival_goer(delta)
		else:
			_approaching = false

	if not _silence_started and _elapsed >= SILENCE_AT:
		_silence_started = true
		_run_silence()


## --- rooms --------------------------------------------------------------------
func _on_stair_used(stair: RoomStair) -> void:
	if _moving:
		return
	var first: bool = not GameState.get_flag("COLDOPEN_USED_STAIR", false)
	await _go_to_room(stair.target_room)
	GameState.set_flag("COLDOPEN_USED_STAIR", true)
	if first:
		_say(FIRST_DESCENT if stair.target_room == "scriptorium" else FIRST_ASCENT, 5.0)


func _go_to_room(name: String) -> void:
	if not ROOMS.has(name):
		push_warning("ColdOpen: unknown room '%s'" % name)
		return
	_moving = true
	var tw := create_tween()
	tw.tween_property(room_fade, "color:a", 1.0, 0.28)
	await tw.finished

	_room = name
	player.global_position = ROOMS[name]["spawn"]
	_apply_room_limits(name)
	# Let the camera settle on the new limits before we show anything.
	await get_tree().process_frame
	camera.reset_smoothing()
	camera.force_update_scroll()

	tw = create_tween()
	tw.tween_property(room_fade, "color:a", 0.0, 0.28)
	await tw.finished
	_moving = false


func _apply_room_limits(name: String) -> void:
	var r: Rect2 = ROOMS[name]["limits"]
	camera.limit_left = int(r.position.x)
	camera.limit_top = int(r.position.y)
	camera.limit_right = int(r.position.x + r.size.x)
	camera.limit_bottom = int(r.position.y + r.size.y)


## --- the one choice, brought to the player ------------------------------------
func _walk_festival_goer(delta: float) -> void:
	var to := player.global_position - festival_goer.global_position
	if to.length() <= APPROACH_STOP_DIST:
		_approaching = false
		_fg_spoke = true
		festival_goer.dialogue = FG_MAIN_DIALOGUE
		festival_goer.interact()
		return
	festival_goer.global_position += to.normalized() * APPROACH_SPEED * delta


func _on_dialogue_finished(id: String) -> void:
	if id == "coldopen_festivalgoer":
		_leave_into_the_crowd()


## Both branches end with her gone — "steps back into the crowd" / "spins away into the gold and the
## noise". Clearing her dialogue also stops the player reopening the exchange and flipping
## COLDOPEN_HONEST, which has to stay the answer they actually gave.
func _leave_into_the_crowd() -> void:
	festival_goer.dialogue = ""
	festival_goer.examine_text = ""
	var tw := create_tween()
	tw.tween_property(festival_goer, "global_position",
		festival_goer.global_position + Vector2(-120, 70), 3.0)
	tw.parallel().tween_property(festival_goer, "modulate:a", 0.0, 3.0)


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
	if _room != "balcony":
		var dim := create_tween()
		dim.tween_property(script_lights, "modulate", DISTRICT_DARK, 1.2)
		await dim.finished
		_say("The lamp goes out. Every lamp goes out. Above you, through the stairwell, the gold on the wall drains away to nothing.", 4.0)
		await get_tree().create_timer(4.6).timeout
		await _go_to_room("balcony")

	await get_tree().create_timer(1.4).timeout

	# District by district, the lights go out — an expanding ring of quiet.
	var tw := create_tween()
	for district in city.get_children():
		tw.tween_property(district, "modulate", DISTRICT_DARK, 0.5)
		tw.tween_interval(0.25)
	tw.parallel().tween_property(festival_lights, "modulate", DISTRICT_DARK, 1.5)
	tw.parallel().tween_property(world_tint, "color", WORLD_MUTED, 3.0)
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
