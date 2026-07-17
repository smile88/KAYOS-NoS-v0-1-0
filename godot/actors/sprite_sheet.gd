class_name SpriteSheet
extends RefCounted
## Turns a character sheet texture into a SpriteFrames, so NPCs and the player can be driven by
## dropping a PNG into a CharacterData rather than hand-authoring an animation resource per person.
##
## The locked sheet format (GDD §13): 48×72 frames, 192×288 sheet, 4 columns × 4 rows, row order
## **down, up, right, left**, walk cycle contact-pass-contact-pass. Animations are named
## "walk_down/up/right/left". A texture that isn't sheet-sized is treated as a single static idle
## for all four directions, so half-finished art still shows *something* instead of erroring.

const FRAME_W := 48
const FRAME_H := 72
const ROWS := ["down", "up", "right", "left"]   # GDD §13 row order, confirmed against CH-001
const DEFAULT_FPS := 8.0


static func frames_from(tex: Texture2D, fps: float = DEFAULT_FPS) -> SpriteFrames:
	var sf := SpriteFrames.new()
	sf.remove_animation("default")
	var full_sheet := tex != null and tex.get_width() >= FRAME_W * 4 and tex.get_height() >= FRAME_H * 4
	for row in range(ROWS.size()):
		var anim: String = "walk_" + ROWS[row]
		sf.add_animation(anim)
		sf.set_animation_speed(anim, fps)
		sf.set_animation_loop(anim, true)
		if full_sheet:
			for col in range(4):
				var at := AtlasTexture.new()
				at.atlas = tex
				at.region = Rect2(col * FRAME_W, row * FRAME_H, FRAME_W, FRAME_H)
				sf.add_frame(anim, at)
		elif tex != null:
			sf.add_frame(anim, tex)      # not a sheet: one static idle frame per direction
	return sf
