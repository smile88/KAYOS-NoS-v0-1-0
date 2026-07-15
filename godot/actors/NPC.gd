extends Interactable
class_name NPC
## A reusable NPC: drop NPC.tscn into a zone, assign a CharacterData in the Inspector, and it
## configures its own name, dialogue, and (placeholder) faction colour. GDD §13.

## Placeholder body colours by faction until CH-### sprites are cleaned in.
const FACTION_COLORS := {
	CharacterData.Faction.NOCTARI: Color(0.42, 0.36, 0.72),  # indigo/violet
	CharacterData.Faction.SOLARI:  Color(0.85, 0.72, 0.38),  # gold
	CharacterData.Faction.ORC:     Color(0.55, 0.36, 0.28),  # rust
	CharacterData.Faction.TERRAN:  Color(0.45, 0.50, 0.42),  # stone-green
	CharacterData.Faction.HUMAN:   Color(0.60, 0.55, 0.50),  # earth
	CharacterData.Faction.OTHER:   Color(0.50, 0.50, 0.55),
}

@export var character_data: CharacterData


func _ready() -> void:
	if character_data:
		if display_name == "":
			display_name = character_data.display_name
		if dialogue == "" and character_data.default_dialogue != "":
			dialogue = character_data.default_dialogue
		if has_node("Body"):
			($Body as Polygon2D).color = FACTION_COLORS.get(character_data.faction, Color.GRAY)
	if has_node("NameLabel"):
		($NameLabel as Label).text = display_name
