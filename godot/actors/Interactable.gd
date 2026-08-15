extends Area2D
class_name Interactable
## A world object the player can talk to or examine (GDD §8, §10). If `dialogue` is set,
## interacting starts that conversation; otherwise `examine_text` shows as a one-line exchange.
## Both render through the shared DialogueUI. Sits on collision layer 2 so the Player's
## Interactor area detects it. Examine-text carries ~30% of the game's characterisation (§8.4) —
## treat it as first-class writing.

@export var display_name: String = ""
@export_multiline var examine_text: String = ""
@export_file("*.json", "*.tres") var dialogue: String = ""
## Optional: a flag set to true the first time the player interacts (tutorial/progress tracking).
@export var flag_on_interact: String = ""
## Optional Asset Bible portrait id (e.g. "PO-014") shown beside `examine_text`. Objects leave this
## empty; a one-line NPC exchange should set it so a passing remark looks like every other
## conversation in the game.
@export var portrait_id: String = ""


@export_group("Class Verbs")
## Optional contextual class verb required to access this interactable's true dialogue/examine text.
## Verbs: 'unmake' (Voidweaver), 'resonate' (Harmonist), 'restore' (Mender),
## 'decipher' (Scholar), 'break' (Chainbreaker), 'vanish' (Whisper)
@export_enum("none", "unmake", "resonate", "restore", "decipher", "break", "vanish") var required_class_verb: String = "none"
@export_multiline var failed_verb_text: String = "A shattered glyph, unreadable to most."


func _has_required_verb() -> bool:
	if required_class_verb == "none" or required_class_verb == "":
		return true
		
	var v := required_class_verb.to_lower()
	var p1 := str(GameState.get_flag("P1_CLASS", "")).to_lower()
	var p2 := str(GameState.get_flag("P2_CLASS", "")).to_lower()
	
	if v == "unmake" and p1 == "voidweaver": return true
	if v == "resonate" and p1 == "harmonist": return true
	if v == "restore" and p1 == "mender": return true
	
	if v == "decipher" and p2 == "scholar": return true
	if v == "break" and p2 == "chainbreaker": return true
	if v == "vanish" and p2 == "whisper": return true
	
	return false

func interact() -> void:
	if not _has_required_verb():
		DialogueManager.start({
			"id": "examine_fail",
			"start": "n",
			"nodes": { "n": {
				"speaker": "",
				"text": "[color=#888888][i]" + failed_verb_text + "[/i][/color]",
				"portrait": "",
			} }
		})
		return
		
	if flag_on_interact != "":
		GameState.set_flag(flag_on_interact, true)
	if dialogue != "":
		DialogueManager.start(dialogue)
	elif examine_text != "":
		var _t := examine_text
		if required_class_verb != "":
			_t = "[color=#88bbff][i](" + required_class_verb.capitalize() + ")[/i][/color] " + _t
		# Wrap a bare examine line in a one-node conversation so it uses the same UI.
		DialogueManager.start({
			"id": "examine",
			"start": "n",
			"nodes": { "n": {
				"speaker": display_name,
				"text": _t,
				"portrait": portrait_id,
			} }
		})
