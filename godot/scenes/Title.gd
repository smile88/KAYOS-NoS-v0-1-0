extends Control
## Minimal title screen (placeholder for UI-011/012). New Game runs the Cold Open;
## Continue restores the last autosave. Swap the key art by dropping UI-011 into
## art/placeholders (or repointing the background TextureRect once it exists).
##
## Post-3D-pivot: New Game now launches the HD-2D 3D Cold Open (threed/ColdOpen3D.tscn).
## The old 2D Cold Open is archived at git tag v0-2d-archive.

const COLD_OPEN_ZONE := "res://threed/ColdOpen3D.tscn"
const FALLBACK_ZONE := "res://scenes/zones/StarfallAcademy.tscn"

@onready var new_game: Button = %NewGame
@onready var continue_btn: Button = %Continue
@onready var quit: Button = %Quit


func _ready() -> void:
	continue_btn.disabled = not FileAccess.file_exists(GameState.SAVE_PATH)
	new_game.pressed.connect(_on_new_game)
	continue_btn.pressed.connect(_on_continue)
	quit.pressed.connect(func(): get_tree().quit())
	new_game.grab_focus()


func _on_new_game() -> void:
	GameState.reset()
	SceneManager.change_zone(COLD_OPEN_ZONE, "",
		"THE SAME NIGHT", "Astra'Thalas · 2000 AO · the winter solstice")


func _on_continue() -> void:
	if GameState.load_game():
		var zone := GameState.current_scene
		if zone == "" or not ResourceLoader.exists(zone):
			zone = FALLBACK_ZONE
		SceneManager.change_zone(zone)
