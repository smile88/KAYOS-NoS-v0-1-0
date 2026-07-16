extends Node2D
## Cold Open director — "The Same Night" (GDD §4.1). Talindir on the Astra'Thalas balcony,
## 2000 AO, the winter solstice. Sequences the four beats:
##   1. movement tutorial (free walk, hint label)
##   2. interaction tutorial — examine the banner, the telescope, the sealed letter
##   3. dialogue tutorial — the festival-goer, the one choice (COLDOPEN_HONEST)
##   4. the event — the lights die district by district; Talindir writes; title card; Starfall.

const EXAMINE_FLAGS := ["COLDOPEN_SAW_BANNER", "COLDOPEN_SAW_TELESCOPE", "COLDOPEN_SAW_LETTER"]
const FG_MAIN_DIALOGUE := "res://data/dialogue/coldopen_festivalgoer.json"
const SILENCE_DIALOGUE := "res://data/dialogue/coldopen_silence.json"
const STARFALL_ZONE := "res://scenes/zones/StarfallAcademy.tscn"

## How dark a silenced district goes, and how muted the world becomes after the Song stops.
const DISTRICT_DARK := Color(0.16, 0.16, 0.24)
const WORLD_MUTED := Color(0.52, 0.55, 0.72)

@onready var hint: Label = %Hint
@onready var festival_goer: NPC = %FestivalGoer
@onready var city: Node2D = %CityBelow
@onready var festival_lights: Node2D = %FestivalLights
@onready var world_tint: CanvasModulate = $CanvasModulate
@onready var story_panel: CanvasLayer = $StoryPanel

var _silence_started := false


func _ready() -> void:
	GameState.current_protagonist = "talindir"
	GameState.flag_changed.connect(_on_flag_changed)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	_refresh_hint()


func _examines_done() -> int:
	var n := 0
	for f in EXAMINE_FLAGS:
		if GameState.get_flag(f, false):
			n += 1
	return n


func _on_flag_changed(key: String, _value) -> void:
	if key.begins_with("COLDOPEN_SAW_"):
		_refresh_hint()


func _refresh_hint() -> void:
	var n := _examines_done()
	if n < EXAMINE_FLAGS.size():
		hint.text = "The Luminarae, 2000 AO — walk (WASD), examine (E): the banner, the telescope, your satchel  (%d/3)" % n
	else:
		hint.text = "A festival-goer has noticed you. Talk to her (E)."
		festival_goer.dialogue = FG_MAIN_DIALOGUE


func _on_dialogue_finished(id: String) -> void:
	if id == "coldopen_festivalgoer" and not _silence_started:
		_silence_started = true
		_run_silence()


## Beat 4 — the Night of Silence, seen from the balcony and not understood.
func _run_silence() -> void:
	hint.text = ""
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
