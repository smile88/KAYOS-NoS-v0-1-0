extends Node2D
## Cold Open director — "The Same Night" (GDD §4.1). Talindir on the Astra'Thalas balcony,
## 2000 AO, the winter solstice.
##
## Design note, because it constrains everything below: **the player cannot cause or prevent
## anything tonight.** Talindir has known for three hundred years and is here anyway, watching.
## So the scene runs on the festival's clock, not on the player's progress — the count reaches the
## ninth bell and the Song stops whether the player examined everything or nothing at all. Nothing
## is gated behind a checklist; there is no "0/3". The player may wander the balcony, ignore it, or
## read every object on it, and the night arrives the same. That powerlessness *is* the thesis
## (GDD §4.1: "The player does not understand what they just saw. That is the point.")
##
## The one choice — COLDOPEN_HONEST — comes to the player: the festival-goer walks over and asks.
## She is not a quest marker to be hunted down.
##
## Framing: the balcony is exactly one 640x360 screen and reads as a single fixed tableau, so the
## scene pins the player's Camera2D limits to it (set on the Camera2D override in the .tscn). The
## whole space is visible at once and walking to an edge never pans off into empty sky.

const FG_MAIN_DIALOGUE := "res://data/dialogue/coldopen_festivalgoer.json"
const SILENCE_DIALOGUE := "res://data/dialogue/coldopen_silence.json"
const STARFALL_ZONE := "res://scenes/zones/StarfallAcademy.tscn"

## The festival's clock, in seconds from the player taking control. Tuned so an unhurried player can
## read every object on the balcony before the bell, while a player who reads nothing still waits
## out the same night. Tests compress this with Engine.time_scale.
const FG_APPROACHES_AT := 42.0
const SILENCE_AT := 145.0

## Talindir's interiority, surfaced non-modally so it never interrupts exploration. These carry the
## dread and telegraph the apex diegetically — the player should *feel* the bell coming without a
## HUD ever counting it down for them.
const BEATS := [
	{ "t": 22.0, "text": "Below, they have begun the count to the ninth bell." },
	{ "t": 68.0, "text": "The garlands draw brighter. The Song is being gathered up — the way breath is gathered before a shout." },
	{ "t": 108.0, "text": "The count is nearly done. On the Tower, a small figure raises his arms." },
]

const CONTROL_PROMPT := "WASD — walk        E — look"
const APPROACH_SPEED := 34.0
const APPROACH_STOP_DIST := 40.0

## How dark a silenced district goes, and how muted the world becomes after the Song stops.
const DISTRICT_DARK := Color(0.16, 0.16, 0.24)
const WORLD_MUTED := Color(0.52, 0.55, 0.72)

@onready var whisper: Label = %Hint
@onready var festival_goer: NPC = %FestivalGoer
@onready var city: Node2D = %CityBelow
@onready var festival_lights: Node2D = %FestivalLights
@onready var world_tint: CanvasModulate = $CanvasModulate
@onready var story_panel: CanvasLayer = $StoryPanel
@onready var player: Node2D = $World/Player

var _elapsed := 0.0
var _next_beat := 0
var _approaching := false
var _fg_spoke := false
var _silence_started := false
var _whisper_tween: Tween


func _ready() -> void:
	GameState.current_protagonist = "talindir"
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	whisper.modulate.a = 0.0
	_say(CONTROL_PROMPT, 6.0)


func _process(delta: float) -> void:
	# The festival's clock holds while a conversation is open, so a slow reader never has the
	# night arrive on top of them mid-sentence.
	if DialogueManager.is_active():
		return
	_elapsed += delta

	if _next_beat < BEATS.size() and _elapsed >= BEATS[_next_beat]["t"]:
		_say(BEATS[_next_beat]["text"], 5.0)
		_next_beat += 1

	if not _fg_spoke and not _approaching and _elapsed >= FG_APPROACHES_AT:
		_approaching = true
	if _approaching:
		_walk_festival_goer(delta)

	if not _silence_started and _elapsed >= SILENCE_AT:
		_silence_started = true
		_run_silence()


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
		festival_goer.global_position + Vector2(-90, 54), 3.0)
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
