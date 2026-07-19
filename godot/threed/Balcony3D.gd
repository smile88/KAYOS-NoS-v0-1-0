extends Zone3D
class_name Balcony3D
## Procedurally builds the Astra Thalas balcony as primitive meshes for the HD-2D 3D Cold Open
## (locked approach: real 3D world, billboard characters). Ports the 2D balcony's shape
## (godot/scenes/zones/AstraThalasBalcony.tscn): a marble platform overlooking the city, a balustrade
## along the far edge, the lit city and the Tower beyond and below it, a sun mosaic inlaid in the
## floor, festival star-lamps, and the stair down at one corner. Environment only — player, camera,
## director are wired by the scene / later steps.
##
## Orientation (see [[kayos-cold-open-3d-branch]] conventions): +Z is toward the default camera
## ("front"); the rail and city sit on the FAR side at -Z so the establishing shot looks out over them.

const PLATFORM_HALF_X := 9.0
const PLATFORM_HALF_Z := 5.5
const RAIL_Z := -PLATFORM_HALF_Z + 0.2   # balustrade just inside the far edge
const RAIL_H := 1.05

## Where the player stands after climbing up from the scriptorium (see RoomCoordinator3D). Near the
## stair, but clear of its RoomStair3D zone so arriving doesn't immediately send them back down.
const SPAWN := Vector3(-6.0, 0.0, 2.6)


func _ready() -> void:
	_build_sky()
	_build_substructure()
	_build_platform()
	_build_sun_mosaic()
	_build_balustrade()
	_build_city()
	_build_tower()
	_build_festival_lights()
	_build_stair()
	_build_interactables()
	_build_npcs()


# --- pieces ------------------------------------------------------------------
# Environment toolkit (_tex / _mat / _box / ART / PLACE) is inherited from Zone3D.

func _build_sky() -> void:
	# Big inverted sphere with the equirect star dome, unshaded — a cheap night sky you can orbit under.
	var sphere := SphereMesh.new()
	sphere.radius = 180.0
	sphere.height = 360.0
	sphere.is_hemisphere = false
	var mi := MeshInstance3D.new()
	mi.name = "SkyDome"
	mi.mesh = sphere
	var m := StandardMaterial3D.new()
	m.albedo_texture = _tex(ART + "star_dome.png")
	m.cull_mode = BaseMaterial3D.CULL_FRONT          # show the inside
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mi.material_override = m
	mi.position = Vector3(0, 0, 0)
	add_child(mi)


func _build_substructure() -> void:
	# The tower wall the balcony juts from: a tall dark mass directly under the platform. It makes the
	# balcony read as high on a building rather than a slab floating in the night, and — because the
	# scriptorium is parented 40 m below — it occludes that lower room from the balcony's wide, high
	# angles (e.g. the Silence tableau), where the eye would otherwise see straight past the near edge
	# down into it. It stops well above the scriptorium so it never fouls that room's own camera.
	var mat := _mat(_tex(ART + "stone.png"), 4.0)
	mat.albedo_color = Color(0.22, 0.23, 0.3)
	_box(Vector3(PLATFORM_HALF_X * 2.0, 14.0, PLATFORM_HALF_Z * 2.0), Vector3(0, -0.4 - 7.0, 0), mat, "Substructure")


func _build_platform() -> void:
	var mat := _mat(_tex(ART + "marble_floor.png"), 6.0)
	# thin slab, top surface at y = 0
	_box(Vector3(PLATFORM_HALF_X * 2.0, 0.4, PLATFORM_HALF_Z * 2.0), Vector3(0, -0.2, 0), mat, "Platform")


func _build_sun_mosaic() -> void:
	# Athalas sun inlaid in the floor centre — a flat textured quad just above the marble.
	var quad := PlaneMesh.new()
	quad.size = Vector2(4.5, 4.5)
	var mi := MeshInstance3D.new()
	mi.name = "SunMosaic"
	mi.mesh = quad
	mi.position = Vector3(0, 0.02, 0.5)
	var tex := _tex(PLACE + "EN-006_sun_mosaic.png")
	var m := _mat(tex, 1.0, 0.25)
	m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mi.material_override = m
	add_child(mi)


func _build_balustrade() -> void:
	var stone := _mat(_tex(ART + "stone.png"), 1.0)
	# top rail spanning the far edge
	_box(Vector3(PLATFORM_HALF_X * 2.0, 0.14, 0.22), Vector3(0, RAIL_H, RAIL_Z), stone, "RailTop")
	# balusters
	var n := int(PLATFORM_HALF_X * 2.0 / 0.7)
	for i in range(n + 1):
		var x := -PLATFORM_HALF_X + i * 0.7
		_box(Vector3(0.12, RAIL_H, 0.12), Vector3(x, RAIL_H * 0.5, RAIL_Z), stone, "Baluster%d" % i)


func _build_city() -> void:
	# Lit districts beyond and below the rail — boxes with an emissive windows texture so they glow
	# like a city at night. Two ragged rows receding into the dark.
	var windows := _tex(ART + "city_windows.png")
	var rng := RandomNumberGenerator.new()
	rng.seed = 20260718
	var rows := [
		{"z": -9.0,  "y_top": -1.5, "e": 0.22},
		{"z": -14.0, "y_top": -2.5, "e": 0.16},
		{"z": -20.0, "y_top": -3.5, "e": 0.10},
	]
	for row in rows:
		var z: float = row["z"]
		var x := -22.0
		while x < 22.0:
			var w := rng.randf_range(1.6, 3.2)
			var h := rng.randf_range(3.0, 7.5)
			var d := rng.randf_range(1.6, 3.0)
			var top: float = row["y_top"]
			var mat := _mat(windows, maxf(1.0, h / 2.0), row["e"])
			mat.albedo_color = Color(0.32, 0.34, 0.44)   # dark masonry; the windows do the glowing
			_box(Vector3(w, h, d), Vector3(x + w * 0.5, top - h * 0.5, z), mat, "Bldg")
			x += w + rng.randf_range(0.3, 1.2)


func _build_tower() -> void:
	# The Tower of Astra Thalas: a tall tapered spire behind the city with a lit apex.
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.6
	cyl.bottom_radius = 2.4
	cyl.height = 30.0
	var mi := MeshInstance3D.new()
	mi.name = "Tower"
	mi.mesh = cyl
	mi.position = Vector3(7.0, 30.0 * 0.5 - 4.0, -19.0)
	mi.material_override = _mat(_tex(ART + "stone.png"), 3.0)
	add_child(mi)

	# glowing apex
	var apex := SphereMesh.new()
	apex.radius = 1.1
	apex.height = 2.2
	var am := MeshInstance3D.new()
	am.mesh = apex
	am.position = mi.position + Vector3(0, 15.5, 0)
	var gm := StandardMaterial3D.new()
	gm.emission_enabled = true
	gm.emission = Color(1.0, 0.86, 0.5)
	gm.emission_energy_multiplier = 4.0
	gm.albedo_color = Color(1.0, 0.9, 0.6)
	am.material_override = gm
	add_child(am)

	var light := OmniLight3D.new()
	light.position = am.position
	light.light_color = Color(1.0, 0.86, 0.55)
	light.light_energy = 4.0
	light.omni_range = 26.0
	add_child(light)


func _build_festival_lights() -> void:
	# Warm star-lamps along the rail: small emissive orbs + point lights, the festival glow.
	for x in [-7.0, -3.5, 0.0, 3.5, 7.0]:
		var orb := SphereMesh.new()
		orb.radius = 0.16
		orb.height = 0.32
		var mi := MeshInstance3D.new()
		mi.mesh = orb
		mi.position = Vector3(x, RAIL_H + 0.5, RAIL_Z + 0.1)
		var m := StandardMaterial3D.new()
		m.emission_enabled = true
		m.emission = Color(1.0, 0.82, 0.45)
		m.emission_energy_multiplier = 3.0
		m.albedo_color = Color(1.0, 0.85, 0.5)
		mi.material_override = m
		add_child(mi)

		var l := OmniLight3D.new()
		l.position = mi.position
		l.light_color = Color(1.0, 0.8, 0.5)
		l.light_energy = 1.6
		l.omni_range = 6.0
		add_child(l)


func _build_interactables() -> void:
	# The balcony's examinables, ported one-for-one from scenes/zones/AstraThalasBalcony.tscn with
	# their text verbatim (§8.4 writing). Positions are mapped from the 2D layout: balcony x [0,1280]
	# -> world x [-9,9]; balcony floor y [340,700] (rail..front) -> world z [-5,5]. `tex` empty means
	# an invisible zone on a piece of the environment (rail, floor mosaic, the light orbs).
	var items := [
		{"name": "Festival Banner", "x": -5.6, "z": -3.6, "model": "banner",
		 "flag": "COLDOPEN_SAW_BANNER",
		 "text": "Gold thread on white silk: THE TWO-THOUSANDTH LUMINARAE. Beneath the sun-sigil, in smaller stitching: 'May the Song hold.' It has held for two thousand years."},
		{"name": "Festival Telescope", "x": 5.9, "z": -3.6, "model": "telescope",
		 "flag": "COLDOPEN_SAW_TELESCOPE",
		 "text": "Set out for the crowds, aimed at the Tower of Celestial Harmony. Through the lens: the whole spire alight, and a tiny silhouette upon it — the Grand Archmage, arms rising with the apex of the ceremony. For a heartbeat you think you see the lights below the Tower flicker. An old man's eyes. Surely."},
		{"name": "Your Satchel", "x": -1.1, "z": 0.6, "model": "satchel",
		 "flag": "COLDOPEN_SAW_LETTER",
		 "text": "Ink, nibs, blotting sand — and beneath them, wrapped in oilcloth, a letter. The hand that wrote your name on it was precise, unhurried, three hundred years gone. The indigo wax seal — a void, held — is unbroken. 'You will know the night,' she said. You have carried it so long you had almost stopped believing there would be one."},
		{"name": "Star-Lamp", "x": -7.0, "z": RAIL_Z + 0.1, "model": "",
		 "text": "No flame in it. There has never been a flame in it — the Solari hang these and the Song fills them, the way water fills a cup you did not know was empty. Every child in Astra'Thalas learns the trick of cupping their hands round one to feel the hum. You do it now, an old man alone at the rail. It hums."},
		{"name": "Star-Lamp", "x": 7.0, "z": RAIL_Z + 0.1, "model": "",
		 "text": "The twin of the one at the far end, and of nine thousand others down in the districts, and of the great ones ringing the Tower. Nobody lights them. Nobody has ever lit them. That is not a thing anyone in this city has ever had to think about, and you are thinking about it now."},
		{"name": "A Child's Sun-Mask", "x": -4.5, "z": 3.3, "model": "mask",
		 "text": "Gold paper on a willow frame, the sun's nine rays cut out by hand. Dropped in the rush to see the Tower, and already trodden on once. Someone will cry about this tomorrow. You catch yourself on the word — tomorrow — and cannot say why it has gone cold in your mouth."},
		{"name": "Your Ledger", "x": -2.4, "z": 2.8, "model": "book",
		 "text": "Sixty years of entries in your own narrowing hand. Weather. Deaths. The price of ink. The chronicle of a city that has never needed chronicling, because nothing here has ever changed. You have long thought your life's work one very long sentence with no verb in it. She promised you a verb."},
		{"name": "Sun-Sigil Mosaic", "x": 0.0, "z": 0.5, "model": "",
		 "text": "Gold tesserae, worn pale by two thousand years of feet. The Solari set these into every high place in the city so the Song would always have somewhere to land. You have never been certain whether that is theology or engineering. You have never been certain the Solari know either."},
		{"name": "Order of Ceremony", "x": 2.1, "z": 2.8, "model": "papers",
		 "text": "THE ORDER OF THE TWO-THOUSANDTH LUMINARAE, struck in gold on cheap pulp. The apex is timed to the ninth bell: the Grand Archmage Sulvaine will draw the Song up through the Tower and return it to the city sevenfold. At the foot, in the smallest type the press could set: by the grace of the Song, which is eternal."},
		{"name": "The Balustrade", "x": 0.0, "z": RAIL_Z, "model": "",
		 "text": "Marble, worn smooth and faintly hollow at exactly the height of a man's forearms. Two thousand years of people leaning here to look at their own city. Sixty of those years are yours. Below, nine thousand move like one animal breathing, and under the streets the Songlines run faint and gold, the way veins run under skin. Nobody looks at them. Nobody has ever had to."},
		{"name": "Initials, Cut in the Rail", "x": 3.7, "z": RAIL_Z, "model": "",
		 "text": "Two sets of initials cut into the underside of the rail, where the wardens would not think to look. The cuts are old. You do not know who they were, and there is no one left to ask. That is the ordinary fate of very nearly everyone. It has never frightened you before tonight."},
		{"name": "Two Cups, Left Behind", "x": 7.2, "z": 3.6, "model": "cups",
		 "text": "Both empty, set side by side on the parapet. Someone brought a friend up here to look at the city and did not stay long. The rims are still sticky — honey, clove, and something floral the Solari have never agreed on a name for."},
	]
	for d in items:
		var it := Interactable3D.new()
		it.name = "IX_" + str(d["name"]).replace(" ", "")
		it.display_name = d["name"]
		it.examine_text = d["text"]
		if d.has("flag"):
			it.flag_on_interact = d["flag"]
		it.prop_model = d["model"]
		it.position = Vector3(d["x"], 0.0, d["z"])
		add_child(it)


## The FestivalGoer sits in group "festival_goer" so the director (step G) can find and walk her.
const FG_EARLY_DIALOGUE := "res://data/dialogue/coldopen_festivalgoer_early.json"


## Muted festival-crowd robe colours so the seven read as different people (the 2D crowd shared one
## silhouette). Cycled by index.
const CROWD_ROBES := [
	Color(0.44, 0.30, 0.22), Color(0.28, 0.36, 0.28), Color(0.42, 0.36, 0.24),
	Color(0.30, 0.30, 0.40), Color(0.46, 0.40, 0.44), Color(0.24, 0.34, 0.38),
	Color(0.40, 0.26, 0.28),
]


func _build_npcs() -> void:
	# The seven balcony wanderers, ported from AstraThalasBalcony.tscn: same examine text (§8.4), now
	# 3D hooded figures in varied robe colours, roam rects mapped from the 2D layout to the XZ ground
	# (Rect2 = minX, minZ, width, depth). They drift, pause, and — at the Silence — rush the rail.
	var crowd := [
		{"name": "The Lamplighter", "x": -7.0, "z": -2.5, "roam": Rect2(-8.2, -3.9, 2.8, 3.6),
		 "text": "\"Sixty-first Luminarae I've worked, and there's nothing to light. There's never anything to light. My father held the office, and his mother before him, and not one of us has ever struck a flame in this city.\" He turns his unlit taper over in his hands. \"Tonight of all nights, scribe, I'd like there to be something to light.\""},
		{"name": "A Reveller, Well On", "x": -3.7, "z": 0.3, "roam": Rect2(-4.8, -1.4, 2.7, 4.2),
		 "text": "\"Two thousand years!\" He holds up two fingers, then looks at them, unconvinced. \"Do you know what that is, scribe? That's — that's a lot of years. That's all of them. That's every year there's ever been.\" He is going to be very unwell tomorrow, and that is the worst thing that is going to happen to him tomorrow."},
		{"name": "A Woman, Looking", "x": -1.1, "z": 4.0, "roam": Rect2(-2.4, 2.2, 3.1, 2.6),
		 "text": "\"Have you seen a boy? So high. Gold mask, the nine rays, he cut it himself and he won't be parted from it.\" She is not frightened yet — it is a festival, and children run. \"He was at the rail a moment ago. He wanted to see the Tower.\""},
		{"name": "Two, Leaning", "x": 0.8, "z": -3.8, "roam": Rect2(0.3, -4.6, 1.7, 1.7),
		 "text": "\"We came up for the view and stayed for the quiet.\" She does not look away from the city while she says it. \"Don't tell them it's quiet up here. They'll all come.\" Beside her he says nothing at all, and has the face of a man who would stand on this balcony for the rest of his life."},
		{"name": "A Solari Celebrant", "x": 4.5, "z": 1.4, "roam": Rect2(3.4, -0.3, 2.7, 3.9),
		 "text": "\"The Song is eternal.\" She says it the way you would say the sky is blue — no fervour in it, none needed. \"Say it with me, scribe, it steadies a person. The Song is eternal, and was here before us, and will be here after.\" She smiles at your face. \"You've gone grey. Sit down. It's a festival.\""},
		{"name": "A Tower Functionary", "x": 6.7, "z": -1.4, "roam": Rect2(5.6, -3.1, 2.8, 3.6),
		 "text": "\"He's been up there since the sixth bell.\" He means Sulvaine; up here tonight everyone means Sulvaine. \"Hasn't eaten. Sent the attendants out.\" He laughs, and it does not come out right. \"They're saying he's nervous. Archmages aren't nervous. It's a ceremony. We've done it two thousand times.\""},
		{"name": "A Bored Warden", "x": 7.7, "z": 3.1, "roam": Rect2(6.8, 1.4, 1.6, 3.3),
		 "text": "\"Same duty every Luminarae: stop the balcony falling into the street.\" He does not look at the balcony. \"Two thousand years, and it has never once tried. I'll be here till the tenth bell and then I'll go and find my wife and she'll be drunk.\" He nods at the crowd, comfortable, incurious, entirely safe."},
	]
	var i := 0
	for d in crowd:
		var w := Wanderer3D.new()
		w.name = "NPC_" + str(d["name"]).replace(" ", "").replace(",", "")
		w.robe_color = CROWD_ROBES[i % CROWD_ROBES.size()]
		w.display_name = d["name"]
		w.examine_text = d["text"]
		w.portrait_id = "PO-014"
		w.roam_rect = d["roam"]
		w.position = Vector3(d["x"], 0.0, d["z"])
		add_child(w)
		i += 1

	# The festival-goer who will (step G) bring the player their one choice. For now she stands among
	# the crowd; examining her opens her early, pre-bell exchange, exactly as before the bell in 2D.
	var fg := NPC3D.new()
	fg.name = "FestivalGoer"
	fg.robe_color = Color(0.50, 0.34, 0.40)   # a warmer rose so she stands out a little in the crowd
	fg.display_name = "Festival-Goer"
	fg.dialogue = FG_EARLY_DIALOGUE
	fg.position = Vector3(2.5, 0.0, -2.2)
	fg.add_to_group("festival_goer")
	add_child(fg)


func _build_stair() -> void:
	# Stair down to the scriptorium at the near-left corner: a short flight of steps you can see and
	# (later) step onto. Marks where the room transition happens.
	var stone := _mat(_tex(ART + "stone.png"), 1.0)
	var base := Vector3(-PLATFORM_HALF_X + 1.6, 0, PLATFORM_HALF_Z - 1.4)
	var steps := 5
	for i in range(steps):
		var y := -0.25 * (i + 1)
		var z := base.z + 0.45 * i
		_box(Vector3(2.4, 0.25, 0.5), Vector3(base.x, y + 0.125, z), stone, "Step%d" % i)

	# The invisible stair-down zone: examining it (F/Space) descends to the scriptorium. The
	# RoomCoordinator3D owns the actual move; this just announces it, exactly as RoomStair does in 2D.
	var stair := RoomStair3D.new()
	stair.name = "StairDown"
	stair.display_name = "The Stair Down"
	stair.target_room = "scriptorium"
	stair.position = base + Vector3(0, 0, 0.9)
	add_child(stair)

# The Song stops: the city (district by district), the Tower and the festival star-lamps drain to
# nothing while the stars stay — Zone3D.drain_to_dark, which the director calls with a small stagger
# so the child order (left-to-right build ≈ a spatial sweep) reads as an expanding ring of quiet.
