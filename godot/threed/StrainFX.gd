extends CanvasLayer
## Manages the post-processing effects and audio for Mental Strain (Frayed, Strained, Breaking).

@onready var fx_rect: ColorRect = $FXRect
@onready var heartbeat_audio: AudioStreamPlayer = $HeartbeatAudio
@onready var tinnitus_audio: AudioStreamPlayer = $TinnitusAudio

var _heartbeat_tween: Tween

func _ready() -> void:
	GameState.strain_changed.connect(_on_strain_changed)
	_update_strain(GameState.mental_strain)

func _on_strain_changed(strain: int, _band: int) -> void:
	_update_strain(strain)

func _update_strain(strain: int) -> void:
	var intensity := float(strain) / 100.0
	
	if fx_rect.material is ShaderMaterial:
		fx_rect.material.set_shader_parameter("strain_intensity", intensity)
	
	# Breaking band heartbeat
	if strain >= 75:
		if not heartbeat_audio.playing:
			heartbeat_audio.volume_db = -20.0
			heartbeat_audio.play()
			var t := create_tween()
			t.tween_property(heartbeat_audio, "volume_db", 0.0, 2.0)
	else:
		if heartbeat_audio.playing:
			var t := create_tween()
			t.tween_property(heartbeat_audio, "volume_db", -40.0, 1.5)
			t.tween_callback(heartbeat_audio.stop)
			
	# Frayed band tinnitus drone
	if strain >= 25:
		if not tinnitus_audio.playing:
			tinnitus_audio.volume_db = -40.0
			tinnitus_audio.play()
		var target_vol := lerpf(-20.0, -5.0, (strain - 25) / 75.0)
		var t := create_tween()
		t.tween_property(tinnitus_audio, "volume_db", target_vol, 1.0)
	else:
		if tinnitus_audio.playing:
			var t := create_tween()
			t.tween_property(tinnitus_audio, "volume_db", -40.0, 2.0)
			t.tween_callback(tinnitus_audio.stop)
