@tool
extends Interactable
class_name NPC
## A reusable NPC: drop NPC.tscn into a zone, assign a CharacterData in the Inspector, and it
## configures its own name, dialogue, and animated sprite. GDD §13. @tool so the editor previews
## the character the moment you pick a .tres.
##
## Art is data-driven: the character's sheet (a 48×72-frame, 192×288, 4×4 walk sheet — see
## SpriteSheet) is sliced into walk_down/up/right/left at load. Swapping a character's look is
## dropping the cleaned PNG into its CharacterData `sprite` slot; every placed instance follows.
## Movers (see Wanderer) call face()/set_moving() to drive the animation.

## Generic labeled placeholder SHEETS by faction, used until a CharacterData provides real art.
const FACTION_PLACEHOLDERS := {
	CharacterData.Faction.NOCTARI: "res://art/placeholders/NPC_generic_noctari.png",
	CharacterData.Faction.SOLARI:  "res://art/placeholders/NPC_generic_solari.png",
	CharacterData.Faction.ORC:     "res://art/placeholders/NPC_generic_orc.png",
	CharacterData.Faction.TERRAN:  "res://art/placeholders/NPC_generic_terran.png",
	CharacterData.Faction.HUMAN:   "res://art/placeholders/NPC_generic_human.png",
	CharacterData.Faction.SYLVARI: "res://art/placeholders/NPC_generic_other.png",
	CharacterData.Faction.OTHER:   "res://art/placeholders/NPC_generic_other.png",
}

@export var character_data: CharacterData : set = _set_character_data

var _facing := "down"
var _moving := false


func _ready() -> void:
	if not Engine.is_editor_hint() and character_data:
		if display_name == "":
			display_name = character_data.display_name
		if dialogue == "" and character_data.default_dialogue != "":
			dialogue = character_data.default_dialogue
	_apply_visuals()


func _set_character_data(value: CharacterData) -> void:
	character_data = value
	if is_inside_tree():
		_apply_visuals()


## Point the sprite in a compass direction ("down"/"up"/"left"/"right") without changing whether
## it's walking or idle. Movers call this every frame from their velocity.
func face(dir: String) -> void:
	if dir == _facing:
		return
	_facing = dir
	_refresh_anim()


## Play the walk cycle while true, hold frame 0 while false.
func set_moving(moving: bool) -> void:
	if moving == _moving:
		return
	_moving = moving
	_refresh_anim()


func _refresh_anim() -> void:
	if not has_node("Body"):
		return
	var body := $Body as AnimatedSprite2D
	if body.sprite_frames == null:
		return
	var anim := "walk_" + _facing
	if not body.sprite_frames.has_animation(anim):
		return
	body.animation = anim
	if _moving:
		if not body.is_playing():
			body.play(anim)
	else:
		body.stop()
		body.frame = 0


func _apply_visuals() -> void:
	if has_node("Body"):
		var body := $Body as AnimatedSprite2D
		body.sprite_frames = _resolve_frames()
		body.animation = "walk_" + _facing
		body.frame = 0
	if has_node("NameLabel"):
		var shown := display_name
		if shown == "" and character_data:
			shown = character_data.display_name
		($NameLabel as Label).text = shown if shown != "" else "NPC"


## Priority: an authored SpriteFrames on the CharacterData wins; else slice the character's sheet
## texture; else fall back to the faction placeholder sheet.
func _resolve_frames() -> SpriteFrames:
	if character_data and character_data.sprite_frames:
		return character_data.sprite_frames
	var tex: Texture2D = null
	if character_data and character_data.sprite:
		tex = character_data.sprite
	elif character_data:
		tex = load(FACTION_PLACEHOLDERS.get(character_data.faction,
			FACTION_PLACEHOLDERS[CharacterData.Faction.OTHER]))
	else:
		tex = load(FACTION_PLACEHOLDERS[CharacterData.Faction.OTHER])
	return SpriteSheet.frames_from(tex)
