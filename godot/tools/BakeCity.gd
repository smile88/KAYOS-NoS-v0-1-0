extends SceneTree
## Command-line utility to bake StarfallCity3D procedural geometry into editable nodes.
## Run with:
## /Applications/Godot_4.7.app/Contents/MacOS/Godot --headless --path godot -s res://tools/BakeCity.gd

func _init() -> void:
	print("Starting Starfall City Scene Baking...")
	var scene_path := "res://threed/StarfallCity3D.tscn"
	var ps := load(scene_path) as PackedScene
	if ps == null:
		push_error("Could not load %s" % scene_path)
		quit(1)
		return

	var root: Node = ps.instantiate()
	var world := root.find_child("World", true, false) as StarfallCity3D
	if world == null:
		push_error("Could not find World node in %s" % scene_path)
		quit(1)
		return

	# Force generation
	world.is_baked = false
	world._ready()

	# Mark as baked so future loads use the serialized nodes
	world.is_baked = true

	# Set owner recursively to root so everything is editable in Godot's Scene Dock & 3D Viewport
	_set_owner_recursive(world, root)

	var packed := PackedScene.new()
	var err := packed.pack(root)
	if err != OK:
		push_error("Failed to pack scene: %d" % err)
		quit(1)
		return

	var save_path := "res://threed/StarfallCity3D.tscn"
	var save_err := ResourceSaver.save(packed, save_path)
	if save_err != OK:
		push_error("Failed to save scene to %s: %d" % [save_path, save_err])
		quit(1)
		return

	print("Successfully baked Starfall City to %s!" % save_path)
	quit(0)


func _set_owner_recursive(node: Node, scene_root: Node) -> void:
	for child in node.get_children():
		child.owner = scene_root
		_set_owner_recursive(child, scene_root)
