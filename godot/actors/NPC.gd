@tool
extends Interactable
class_name NPC
## A reusable NPC: drop NPC.tscn into a zone, assign a CharacterData in the Inspector, and it
## configures its own name, dialogue, and sprite. GDD §13. @tool so the editor previews the
## character the moment you pick a .tres — swapping art is: open the character's .tres, drag the
## cleaned PNG into its `sprite` slot, and every placed instance updates.

## Generic labeled placeholders by faction, used until a CharacterData provides a real sprite.
const FACTION_PLACEHOLDERS := {
	CharacterData.Faction.NOCTARI: "res://art/placeholders/NPC_generic_noctari.png",
	CharacterData.Faction.SOLARI:  "res://art/placeholders/NPC_generic_solari.png",
	CharacterData.Faction.ORC:     "res://art/placeholders/NPC_generic_orc.png",
	CharacterData.Faction.TERRAN:  "res://art/placeholders/NPC_generic_terran.png",
	CharacterData.Faction.HUMAN:   "res://art/placeholders/NPC_generic_human.png",
	CharacterData.Faction.OTHER:   "res://art/placeholders/NPC_generic_other.png",
}

@export var character_data: CharacterData : set = _set_character_data


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


func _apply_visuals() -> void:
	if has_node("Body"):
		var body := $Body as Sprite2D
		if character_data and character_data.sprite:
			body.texture = character_data.sprite
		elif character_data:
			body.texture = load(FACTION_PLACEHOLDERS.get(character_data.faction,
				FACTION_PLACEHOLDERS[CharacterData.Faction.OTHER]))
	if has_node("NameLabel"):
		var shown := display_name
		if shown == "" and character_data:
			shown = character_data.display_name
		($NameLabel as Label).text = shown if shown != "" else "NPC"
