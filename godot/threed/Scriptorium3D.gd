extends Node3D
class_name Scriptorium3D
## Procedurally builds Talindir's scriptorium — the Astral Archive room below the balcony — as primitive
## meshes for the HD-2D 3D Cold Open. The second room of the single scene (in 2D it was AstraThalasBalcony
## .tscn's lower half, world y 720..1440); here it is its own Node3D, offset well below the balcony in
## real space (the scene parents it at y ≈ -40) so the two rooms never overlap and the RoomCoordinator3D
## can drop the player into it and retarget the camera on stair use.
##
## Everything is built in LOCAL space with the floor at local y = 0; the node's own transform carries it
## down to the world. Its ~13 examinables port one-for-one from the 2D scriptorium with their §8.4 text
## verbatim. Orientation matches the balcony: +Z is toward the default camera ("front"), so the back
## wall, window and shelving sit at -Z.

## Where the coordinator sets the player down when they descend (local space; the scene offset carries
## it to the world). Kept clear of the stair-up so arriving doesn't immediately re-trigger it.
const SPAWN := Vector3(-5.5, 0.0, -0.5)

const ART := "res://art/3d/"
const PLACE := "res://art/placeholders/"

const HALF_X := 9.5
const HALF_Z := 6.5
const WALL_H := 4.0


func _ready() -> void:
	_build_floor()
	_build_walls()
	_build_window()
	_build_shelving()
	_build_lights()
	_build_interactables()
	_build_stair_up()


# --- helpers (same conventions as Balcony3D) ---------------------------------

func _tex(path: String) -> Texture2D:
	return load(path) as Texture2D


func _mat(tex: Texture2D, uv_scale := 1.0, emission := 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	if tex:
		m.albedo_texture = tex
		m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		m.uv1_scale = Vector3(uv_scale, uv_scale, 1.0)
	if emission > 0.0:
		m.emission_enabled = true
		m.emission_texture = tex
		m.emission = Color(1, 1, 1)
		m.emission_energy_multiplier = emission
	return m


func _box(size: Vector3, pos: Vector3, mat: Material, name := "Box") -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.name = name
	mi.mesh = mesh
	mi.position = pos
	if mat:
		mi.material_override = mat
	add_child(mi)
	return mi


# 2D -> local mapping, matching the balcony's scheme. 2D x [0,1280] -> x [-9,9];
# scriptorium 2D y [720,1440] (the lower room) -> z [-6,6] (far wall .. open front).
func _sx(x2d: float) -> float:
	return x2d / 1280.0 * 18.0 - 9.0


func _sz(y2d: float) -> float:
	return (y2d - 720.0) / 720.0 * 12.0 - 6.0


# --- pieces ------------------------------------------------------------------

func _build_floor() -> void:
	var mat := _mat(_tex(PLACE + "EN-019_scriptorium_floor.png"), 5.0)
	_box(Vector3(HALF_X * 2.0, 0.4, HALF_Z * 2.0), Vector3(0, -0.2, 0), mat, "Floor")


func _build_walls() -> void:
	var mat := _mat(_tex(PLACE + "EN-019_scriptorium_wall.png"), 3.0)
	# Back wall at -Z, and side walls at ±X. Front (+Z) is left open so the 360° orbit stays usable
	# and the room reads as a lit tableau you look into (no ceiling for the same reason).
	_box(Vector3(HALF_X * 2.0, WALL_H, 0.4), Vector3(0, WALL_H * 0.5, -HALF_Z), mat, "WallBack")
	_box(Vector3(0.4, WALL_H, HALF_Z * 2.0), Vector3(-HALF_X, WALL_H * 0.5, 0), mat, "WallLeft")
	_box(Vector3(0.4, WALL_H, HALF_Z * 2.0), Vector3(HALF_X, WALL_H * 0.5, 0), mat, "WallRight")


func _build_window() -> void:
	# A tall window in the back wall — the festival seen at a distance and through old glass. An
	# emissive quad set just in front of the wall so gold light lies in the room without warming it.
	var quad := PlaneMesh.new()
	quad.size = Vector2(2.4, 2.6)
	quad.orientation = PlaneMesh.FACE_Z
	var mi := MeshInstance3D.new()
	mi.name = "Window"
	mi.mesh = quad
	mi.position = Vector3(_sx(900.0), 1.7, -HALF_Z + 0.25)
	# Emissive but gentle — high energy blows the pane to a featureless white slab (the same bloom trap
	# the balcony's city hit). Keep it low with a warm tint so the festival reads as gold through glass.
	var m := _mat(_tex(ART + "window_glow.png"), 1.0, 0.3)
	m.emission = Color(1.0, 0.9, 0.66)
	m.albedo_color = Color(0.5, 0.46, 0.36)
	mi.material_override = m
	add_child(mi)

	var l := OmniLight3D.new()
	l.position = mi.position + Vector3(0, 0, 1.2)
	l.light_color = Color(0.95, 0.82, 0.55)
	l.light_energy = 1.1
	l.omni_range = 9.0
	add_child(l)


func _build_shelving() -> void:
	# A run of bookshelves against the back wall behind the scroll racks — solid mass so the room has
	# depth beyond the flat billboard props.
	var wood := _mat(_tex(ART + "shelf_wood.png"), 2.0)
	for x in [-6.2, -3.1, 0.0]:
		_box(Vector3(2.4, 3.2, 0.6), Vector3(x, 1.6, -HALF_Z + 0.6), wood, "Shelf")


func _build_lights() -> void:
	# Warm archive light — a couple of low lamps so the room feels candlelit rather than moonlit like
	# the balcony above it. The Reading Lamp examinable gets its own glow in _build_interactables' data.
	for p in [Vector3(-3.4, 2.4, 0.5), Vector3(3.4, 2.4, 1.5)]:
		var l := OmniLight3D.new()
		l.position = p
		l.light_color = Color(1.0, 0.86, 0.62)
		l.light_energy = 1.4
		l.omni_range = 8.0
		add_child(l)


func _build_interactables() -> void:
	# The scriptorium's examinables, ported one-for-one from scenes/zones/AstraThalasBalcony.tscn (the
	# lower room) with their examine text verbatim. `tex` empty = an invisible zone on the environment
	# (the window in the wall, the reading lamp). Positions map from the 2D layout via _sx/_sz.
	var items := [
		{"name": "The Duty Roster", "x": 200, "y": 900, "tex": "PR-008_roster",
		 "text": "Tonight's watch, in your own hand. Ninth bell: Sorrel. Tenth: Vashti. Eleventh: the Ferrin boy, whose name you never learned to spell. Every line struck through, each in its own apologetic ink, each with the same excuse written small beside it. They are all down there dancing. You did not strike your own name through. Nobody asked you to.",
		 "lift": 1.4},
		{"name": "Scroll Rack — Recent Years", "x": 300, "y": 900, "tex": "PR-007_scroll_rack",
		 "text": "The last two centuries, in the hands of eleven scribes, four of them yours. Harvest yields. Tower maintenance. A dispute about a boundary wall that ran forty years and was settled by both parties dying. Nothing in this rack has ever mattered. You have loved it more than you have loved most people.",
		 "lift": 1.4},
		{"name": "Scroll Rack — the Middle Ages", "x": 420, "y": 900, "tex": "PR-007_scroll_rack",
		 "text": "Eight hundred years compressed into one rack, because so little happened in them. The Age of Order is not a story. It is the absence of one. Somewhere in here is the year you arrived in this city, and you could find it in a moment, and you never have.",
		 "lift": 1.4},
		{"name": "Scroll Rack — the Empty Shelf", "x": 540, "y": 900, "tex": "PR-007_scroll_rack",
		 "text": "The rack for the years still to come, built by an optimist two thousand years ago and not yet a third full. There is room on it for another six hundred years of harvest yields. You have never once looked at this shelf and felt what you feel looking at it now.",
		 "lift": 1.4},
		{"name": "The Scriptorium Window", "x": 900, "y": 900, "tex": "",
		 "z_override": -HALF_Z + 0.6,
		 "text": "The festival, at a distance and through old glass, which is the way you have taken in most things. Gold light lies across the desks in long bars and does not warm them. From here the crowd makes no sound at all. You could watch the whole of it from this chair and never be in any of it. You have."},
		{"name": "The Locked Cabinet", "x": 1140, "y": 900, "tex": "PR-020_cabinet",
		 "text": "Indigo lacquer, and a keyhole you have the key to. This is where the letter lived for three hundred years — through four Grand Archmages, two plagues and a coronation, while you told yourself that the night she meant was not this one and had not come yet. You took it out this evening. You are aware that you took it out this evening. You have not let yourself look at why.",
		 "lift": 1.4},
		{"name": "Your Desk", "x": 400, "y": 1080, "tex": "EN-019_desk",
		 "text": "Sixty years of the same chair, worn to the shape of you. Tonight's page is begun and abandoned: 'The two-thousandth Luminarae. The city is —' and there the ink stops, because you could not think of the word and went upstairs instead. The nib has dried. It will not be the sentence you finish tonight.",
		 "lift": 0.9},
		{"name": "A Cold Cup", "x": 320, "y": 1120, "tex": "EN-019_tea",
		 "text": "Long cold, with a skin on it. You made it at the seventh bell, meaning to drink it, and then the light through the window went the colour it goes and you went up to look at the sky instead. It has been a very long time since anything made you forget a cup of tea."},
		{"name": "Wax and Matrix", "x": 520, "y": 1140, "tex": "PR-008_seal_kit",
		 "text": "Your sealing wax is archive-grey, as every scribe's is. But there is one stick of indigo in the bottom of the drawer, and you did not buy it, and it has sat there three hundred years going slowly hard. The matrix that matches it is not here. She kept that. Of course she kept that."},
		{"name": "Volume the First", "x": 700, "y": 1000, "tex": "PR-008_volume_one",
		 "text": "The oldest book in the room, in a hand two thousand years dead, opening the Age of Order with a sentence every apprentice copies out and none of them think about: 'Let it be recorded that on this day the Song was made steady, and will not fail, and there is therefore nothing further to record.' The rest of the volume is blank. He was so nearly right."},
		{"name": "Document Chest", "x": 880, "y": 1180, "tex": "PR-020_chest",
		 "text": "Deeds, mostly, and the tedious immortal paperwork of a city that expects to go on forever: water rights, tower levies, a folder of complaints about the bells. Underneath it all, a survey of the Songlines, drawn when someone still thought they were worth surveying. It is nine hundred years old. It is the newest one there is."},
		{"name": "The Apprentice's Desk", "x": 1050, "y": 1280, "tex": "EN-019_desk",
		 "text": "Sorrel's. Neat, which yours never was at her age. A half-copied inventory, a pressed flower doing duty as a bookmark, and a note in her round hand: 'Back before the ninth — don't tell.' She is nineteen. She has gone to watch the sky catch fire with a boy from the granary. You would not have told.",
		 "lift": 0.9},
		{"name": "The Reading Lamp", "x": 640, "y": 1300, "tex": "",
		 "text": "You have read by this lamp for sixty years and never once wondered where the light in it comes from, any more than you wonder where the floor comes from. It is the Song. Everything here is the Song. Put your hand near the glass: that faint pressure against your palm is the hum of the world holding itself together, and it has never, in two thousand years, so much as stuttered.",
		 "lamp": true},
	]
	for d in items:
		var it := Interactable3D.new()
		it.name = "SX_" + str(d["name"]).replace(" ", "").replace("—", "").replace(",", "")
		it.display_name = d["name"]
		it.examine_text = d["text"]
		it.portrait_id = ""
		var tex_name: String = d["tex"]
		if tex_name != "":
			it.prop_texture = _tex(PLACE + tex_name + ".png")
		var z: float = d["z_override"] if d.has("z_override") else _sz(float(d["y"]))
		it.position = Vector3(_sx(float(d["x"])), 0.0, z)
		add_child(it)

		# The reading lamp casts its own warm pool of light where it stands.
		if d.has("lamp"):
			var l := OmniLight3D.new()
			l.position = it.position + Vector3(0, 1.0, 0)
			l.light_color = Color(1.0, 0.84, 0.55)
			l.light_energy = 1.8
			l.omni_range = 5.0
			add_child(l)


func _build_stair_up() -> void:
	# The flight back up to the balcony, at the room's near-left, plus the invisible RoomStair3D zone
	# on it. Steps rise toward the open front so you can see them; the coordinator does the actual move.
	var stone := _mat(_tex(ART + "stone.png"), 1.0)
	var base := Vector3(_sx(120.0), 0, _sz(954.0))
	var steps := 5
	for i in range(steps):
		var y := 0.25 * (i + 1)
		var z := base.z + 0.45 * i
		_box(Vector3(2.4, 0.25, 0.5), Vector3(base.x, y - 0.125, z), stone, "StepUp%d" % i)

	var stair := RoomStair3D.new()
	stair.name = "StairUp"
	stair.display_name = "The Stair Up"
	stair.target_room = "balcony"
	stair.position = base + Vector3(0, 0, 0.9)
	add_child(stair)
