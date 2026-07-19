class_name PropModels3D
extends RefCounted
## A library of low-poly 3D prop models (Daggerfall↔Morrowind register) built from primitives, keyed by
## a string. Interactable3D calls `PropModels3D.build(kind)` and stands the result at the prop's spot.
## Each model is built base-at-origin (feet at y = 0). Placeholders — real modelled art replaces them
## the same way it replaces the placeholder textures.

const ART := "res://art/3d/"


static func build(kind: String) -> Node3D:
	var root := Node3D.new()
	match kind:
		"desk": _desk(root)
		"cabinet": _cabinet(root)
		"chest": _chest(root)
		"scroll_rack": _scroll_rack(root)
		"bookshelf": _bookshelf(root)
		"book": _book(root)
		"papers": _papers(root)
		"roster": _roster(root)
		"cup": _cup(root, Vector3.ZERO)
		"cups": _cups(root)
		"mask": _mask(root)
		"banner": _banner(root)
		"telescope": _telescope(root)
		"satchel": _satchel(root)
		"seal": _seal(root)
		_: _generic(root)
	return root


# --- shared helpers ----------------------------------------------------------

static func _wood() -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_texture = load(ART + "shelf_wood.png")
	m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	m.uv1_scale = Vector3(2, 2, 1)
	m.roughness = 0.9
	return m


static func _flat(c: Color, rough := 0.9) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	m.roughness = rough
	return m


static func _box(parent: Node3D, size: Vector3, pos: Vector3, mat: Material) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = pos
	parent.add_child(mi)
	return mi


static func _cyl(parent: Node3D, r: float, h: float, pos: Vector3, mat: Material, rot := Vector3.ZERO) -> MeshInstance3D:
	var mesh := CylinderMesh.new()
	mesh.top_radius = r
	mesh.bottom_radius = r
	mesh.height = h
	mesh.radial_segments = 10
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = pos
	mi.rotation = rot
	parent.add_child(mi)
	return mi


# --- furniture ---------------------------------------------------------------

static func _desk(p: Node3D) -> void:
	var w := _wood()
	_box(p, Vector3(1.6, 0.09, 0.8), Vector3(0, 0.78, 0), w)
	for dx in [-0.72, 0.72]:
		for dz in [-0.32, 0.32]:
			_box(p, Vector3(0.09, 0.78, 0.09), Vector3(dx, 0.39, dz), w)
	_box(p, Vector3(0.28, 0.05, 0.36), Vector3(-0.4, 0.85, 0), _flat(Color(0.9, 0.88, 0.78)))   # paper
	_box(p, Vector3(0.1, 0.14, 0.1), Vector3(0.4, 0.9, -0.1), _flat(Color(0.2, 0.2, 0.24)))      # inkpot


static func _cabinet(p: Node3D) -> void:
	_box(p, Vector3(1.0, 1.7, 0.55), Vector3(0, 0.85, 0), _flat(Color(0.20, 0.16, 0.34)))         # indigo body
	var door := _flat(Color(0.26, 0.21, 0.42))
	_box(p, Vector3(0.44, 1.5, 0.04), Vector3(-0.24, 0.9, 0.29), door)
	_box(p, Vector3(0.44, 1.5, 0.04), Vector3(0.24, 0.9, 0.29), door)
	var brass := _flat(Color(0.7, 0.6, 0.3), 0.5)
	_box(p, Vector3(0.05, 0.12, 0.05), Vector3(-0.03, 0.9, 0.32), brass)
	_box(p, Vector3(0.05, 0.12, 0.05), Vector3(0.03, 0.9, 0.32), brass)


static func _chest(p: Node3D) -> void:
	var w := _wood()
	_box(p, Vector3(1.0, 0.5, 0.6), Vector3(0, 0.25, 0), w)
	_box(p, Vector3(1.02, 0.18, 0.62), Vector3(0, 0.58, 0), w)                                    # lid
	var iron := _flat(Color(0.18, 0.18, 0.2), 0.6)
	for dx in [-0.35, 0.0, 0.35]:
		_box(p, Vector3(0.06, 0.72, 0.63), Vector3(dx, 0.36, 0), iron)


static func _scroll_rack(p: Node3D) -> void:
	var w := _wood()
	for dx in [-0.5, 0.5]:
		_box(p, Vector3(0.08, 1.8, 0.5), Vector3(dx, 0.9, 0), w)
	var sc := _flat(Color(0.86, 0.82, 0.7))
	for y in [0.5, 1.0, 1.5]:
		_box(p, Vector3(1.0, 0.06, 0.5), Vector3(0, y, 0), w)
		for i in range(4):
			_cyl(p, 0.05, 0.44, Vector3(-0.33 + i * 0.22, y + 0.09, 0), sc, Vector3(deg_to_rad(90), 0, 0))


static func _bookshelf(p: Node3D) -> void:
	var w := _wood()
	_box(p, Vector3(2.2, 3.0, 0.5), Vector3(0, 1.5, -0.05), w)
	var colors := [Color(0.5, 0.2, 0.2), Color(0.2, 0.3, 0.45), Color(0.3, 0.4, 0.25), Color(0.45, 0.4, 0.2)]
	for row in range(4):
		_box(p, Vector3(2.1, 0.06, 0.44), Vector3(0, 0.5 + row * 0.62, 0.05), w)
		for i in range(9):
			_box(p, Vector3(0.11, 0.4, 0.3), Vector3(-0.95 + i * 0.22, 0.75 + row * 0.62, 0.08),
				_flat(colors[(i + row) % colors.size()]))


# --- small props -------------------------------------------------------------

static func _book(p: Node3D) -> void:
	_box(p, Vector3(0.32, 0.09, 0.24), Vector3(0, 0.05, 0), _flat(Color(0.35, 0.22, 0.18)))        # cover
	_box(p, Vector3(0.28, 0.06, 0.20), Vector3(0.02, 0.05, 0), _flat(Color(0.86, 0.82, 0.7)))      # pages


static func _papers(p: Node3D) -> void:
	var cream := _flat(Color(0.88, 0.85, 0.74))
	for i in range(3):
		var sheet := _box(p, Vector3(0.34, 0.015, 0.44), Vector3(0, 0.02 + i * 0.02, 0), cream)
		sheet.rotation.y = deg_to_rad(i * 5 - 5)


static func _roster(p: Node3D) -> void:
	var w := _wood()
	_box(p, Vector3(0.06, 0.9, 0.06), Vector3(-0.28, 0.45, 0), w)                                  # frame legs
	_box(p, Vector3(0.06, 0.9, 0.06), Vector3(0.28, 0.45, 0), w)
	_box(p, Vector3(0.62, 0.5, 0.04), Vector3(0, 0.72, 0), _flat(Color(0.86, 0.83, 0.72)))         # board
	var ink := _flat(Color(0.25, 0.22, 0.2))
	for i in range(5):
		_box(p, Vector3(0.44, 0.015, 0.005), Vector3(0, 0.86 - i * 0.07, 0.021), ink)              # ruled lines


static func _cup(p: Node3D, at: Vector3) -> void:
	_cyl(p, 0.07, 0.11, at + Vector3(0, 0.055, 0), _flat(Color(0.75, 0.72, 0.62)))
	_cyl(p, 0.055, 0.09, at + Vector3(0, 0.075, 0), _flat(Color(0.3, 0.35, 0.3)))                  # (tea) contents


static func _cups(p: Node3D) -> void:
	_cup(p, Vector3(-0.09, 0, 0))
	_cup(p, Vector3(0.09, 0, 0.03))


static func _mask(p: Node3D) -> void:
	var gold := _flat(Color(0.82, 0.66, 0.28), 0.5)
	_cyl(p, 0.14, 0.02, Vector3(0, 0.02, 0), gold, Vector3(deg_to_rad(90), 0, 0))                  # disc lying
	for i in range(8):
		var a := i * PI / 4.0
		var ray := _box(p, Vector3(0.03, 0.02, 0.10), Vector3(cos(a) * 0.18, 0.02, sin(a) * 0.18), gold)
		ray.rotation.y = -a


static func _banner(p: Node3D) -> void:
	var pole := _flat(Color(0.4, 0.3, 0.2))
	_cyl(p, 0.03, 1.7, Vector3(0, 0.85, 0), pole)
	_cyl(p, 0.5, 0.05, Vector3(0, 1.66, 0), pole, Vector3(0, 0, deg_to_rad(90)))                   # crossbar
	_box(p, Vector3(0.8, 1.1, 0.02), Vector3(0, 1.05, 0.02), _flat(Color(0.9, 0.87, 0.8)))         # cloth
	_box(p, Vector3(0.8, 0.14, 0.03), Vector3(0, 1.2, 0.03), _flat(Color(0.82, 0.66, 0.28), 0.5))  # gold band


static func _telescope(p: Node3D) -> void:
	var brass := _flat(Color(0.66, 0.55, 0.28), 0.4)
	var tube := _cyl(p, 0.07, 0.9, Vector3(0, 1.1, 0), brass, Vector3(deg_to_rad(60), 0, 0))
	var leg := _flat(Color(0.35, 0.28, 0.2))
	for a in [0.0, 2.09, 4.19]:
		var l := _cyl(p, 0.03, 1.15, Vector3(cos(a) * 0.28, 0.55, sin(a) * 0.28), leg)
		l.rotation = Vector3(deg_to_rad(14) * cos(a + PI), 0, deg_to_rad(14) * sin(a + PI))


static func _satchel(p: Node3D) -> void:
	var leather := _flat(Color(0.4, 0.28, 0.18))
	_box(p, Vector3(0.34, 0.28, 0.16), Vector3(0, 0.14, 0), leather)
	_box(p, Vector3(0.36, 0.14, 0.03), Vector3(0, 0.22, 0.09), _flat(Color(0.32, 0.22, 0.14)))     # flap
	_box(p, Vector3(0.05, 0.34, 0.02), Vector3(0, 0.2, 0.1), _flat(Color(0.25, 0.18, 0.12)))       # strap


static func _seal(p: Node3D) -> void:
	_box(p, Vector3(0.3, 0.1, 0.22), Vector3(0, 0.05, 0), _wood())                                 # tray
	_cyl(p, 0.03, 0.14, Vector3(-0.06, 0.12, 0), _flat(Color(0.22, 0.2, 0.42)))                    # indigo wax stick
	_box(p, Vector3(0.09, 0.06, 0.09), Vector3(0.07, 0.09, 0), _flat(Color(0.6, 0.5, 0.28), 0.5))  # matrix


static func _generic(p: Node3D) -> void:
	_box(p, Vector3(0.3, 0.3, 0.3), Vector3(0, 0.15, 0), _flat(Color(0.5, 0.5, 0.55)))
