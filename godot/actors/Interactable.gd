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


func interact() -> void:
	if flag_on_interact != "":
		GameState.set_flag(flag_on_interact, true)
	if dialogue != "":
		DialogueManager.start(dialogue)
	elif examine_text != "":
		# Wrap a bare examine line in a one-node conversation so it uses the same UI.
		DialogueManager.start({
			"id": "examine",
			"start": "n",
			"nodes": { "n": { "speaker": display_name, "text": examine_text } }
		})
