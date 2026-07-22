extends Node
## Render a few hero angles of the Starfall city to PNGs, so architecture changes can be *seen*
## (not just tested). Run windowed (needs a display):
##   godot --path godot res://tests/Shot.tscn
## Writes to art/greybox_renders/city_*.png, then quits.

const SCENE := "res://threed/StarfallCity3D.tscn"
const OUT := "C:/Users/Smile/KAYOS-NoS-v0-1-0/art/greybox_renders/"

var _shots := [
	# name, camera position, look-at target
	["establish", Vector3(150, 105, 470), Vector3(0, 18, 250)],   # rim overlook, down the Processional
	["terraces", Vector3(250, 70, 300), Vector3(60, 30, 250)],    # 3/4 across the stepped terraces
	["canal", Vector3(178, 33, 231), Vector3(72, 16, 250)],       # 3/4 over the canal quarter
	["rimseat", Vector3(150, 62, 430), Vector3(120, 50, 395)],    # a House seat on the rim, close
]

var _cam: Camera3D


func _ready() -> void:
	get_window().size = Vector2i(1600, 900)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	add_child((load(SCENE) as PackedScene).instantiate())
	_cam = Camera3D.new()
	_cam.fov = 60
	add_child(_cam)
	await get_tree().process_frame
	for k in range(50):                    # let the city build + lights/textures settle
		await get_tree().process_frame
	for shot in _shots:
		_cam.current = true
		_cam.global_position = shot[1]
		_cam.look_at(shot[2], Vector3.UP)
		for k in range(10):
			await get_tree().process_frame
		var img := get_viewport().get_texture().get_image()
		img.save_png(OUT + "city_%s.png" % shot[0])
		print("saved city_%s.png" % shot[0])
	get_tree().quit(0)
