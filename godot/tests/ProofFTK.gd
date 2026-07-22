extends Node
## Proof: import a few Kenney Fantasy Town Kit modules, print their local sizes (to calibrate the
## assembler grid), and render a strip so we can confirm the textures load and the look fits.
const A := "res://assets/ftk/"
const MODS := ["wall.glb", "wall-window-glass.glb", "wall-window-shutters.glb", "wall-wood-door.glb",
	"wall-wood-block.glb", "roof-gable.glb", "roof.glb", "chimney.glb"]


func _ready() -> void:
	get_window().size = Vector2i(1700, 700)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	var we := WorldEnvironment.new()
	var e := Environment.new()
	e.background_mode = Environment.BG_COLOR
	e.background_color = Color(0.18, 0.2, 0.28)
	e.ambient_light_color = Color(1, 1, 1)
	e.ambient_light_energy = 0.7
	we.environment = e
	add_child(we)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48, -38, 0)
	sun.light_energy = 1.3
	add_child(sun)

	var x := 0.0
	for m in MODS:
		var ps := load(A + m) as PackedScene
		if ps == null:
			printerr("LOAD FAIL ", m)
			continue
		var inst: Node3D = ps.instantiate()
		add_child(inst)
		inst.position = Vector3(x, 0, 0)
		var mesh_aabb := _first_aabb(inst)
		print(m, "  size=", mesh_aabb.size, "  origin=", mesh_aabb.position)
		x += maxf(mesh_aabb.size.x, 1.0) + 0.6

	var cam := Camera3D.new()
	add_child(cam)
	cam.current = true
	cam.position = Vector3(x * 0.5 - 0.3, 2.4, 7.5)
	cam.look_at(Vector3(x * 0.5 - 0.3, 1.2, 0), Vector3.UP)
	for k in range(24):
		await get_tree().process_frame
	get_viewport().get_texture().get_image().save_png("C:/Users/Smile/KAYOS-NoS-v0-1-0/art/greybox_renders/ftk_proof.png")
	print("saved ftk_proof.png")
	get_tree().quit(0)


func _first_aabb(n: Node) -> AABB:
	if n is MeshInstance3D and (n as MeshInstance3D).mesh:
		return (n as MeshInstance3D).mesh.get_aabb()
	for c in n.get_children():
		var a := _first_aabb(c)
		if a.size != Vector3.ZERO:
			return a
	return AABB()
