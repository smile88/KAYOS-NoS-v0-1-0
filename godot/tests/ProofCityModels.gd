extends Node
## Visual check for the markers-only redesign: the entrance cut, the flat walkway, the caldera peaks,
## the Under-Terraces cavity, and the marker system standing in for every building/tower/prop.

func _ready() -> void:
	get_window().size = Vector2i(1280, 800)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED

	var city := StarfallCity3D.new()
	add_child(city)

	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50, -40, 0)
	sun.light_energy = 1.3
	sun.light_color = Color(0.85, 0.85, 0.95)
	add_child(sun)
	var amb := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.05, 0.06, 0.1)
	env.ambient_light_color = Color(0.5, 0.55, 0.7)
	env.ambient_light_energy = 0.6
	amb.environment = env
	add_child(amb)

	var cam := Camera3D.new()
	add_child(cam)
	cam.current = true

	for k in range(20):
		await get_tree().process_frame

	# Shot 1: standing at the new spawn point, looking inward down the entrance walkway.
	cam.position = Vector3(0, 15.0, 440.0)
	cam.look_at(Vector3(0, 12.0, 250.0), Vector3.UP)
	for k in range(6):
		await get_tree().process_frame
	get_viewport().get_texture().get_image().save_png(
		"/private/tmp/claude-501/-Users-admin-Projects-KAYOS-NoS-v0-1-0/439334db-e78a-43b3-a4a3-76ddda5c9ebe/scratchpad/entrance_view.png")
	print("saved entrance_view.png")

	# Shot 2: wide aerial over the whole city — the entrance cut, markers, peaks all visible at once.
	cam.position = Vector3(0, 650.0, 550.0)
	cam.look_at(Vector3(0, 0.0, 0.0), Vector3.UP)
	for k in range(6):
		await get_tree().process_frame
	get_viewport().get_texture().get_image().save_png(
		"/private/tmp/claude-501/-Users-admin-Projects-KAYOS-NoS-v0-1-0/439334db-e78a-43b3-a4a3-76ddda5c9ebe/scratchpad/aerial_view.png")
	print("saved aerial_view.png")

	# Shot 3: down into the Under-Terraces cavity.
	cam.position = Vector3(250.0, -3.0, 0.0)
	cam.look_at(Vector3(250.0, -8.0, 0.0), Vector3.UP)
	for k in range(6):
		await get_tree().process_frame
	get_viewport().get_texture().get_image().save_png(
		"/private/tmp/claude-501/-Users-admin-Projects-KAYOS-NoS-v0-1-0/439334db-e78a-43b3-a4a3-76ddda5c9ebe/scratchpad/under_terraces_view.png")
	print("saved under_terraces_view.png")

	get_tree().quit(0)
