extends Node
## AudioManager — music / ambient buses. Audio is P4/placeholder for v1.0 (GDD §13, §14).
## STUB (Phase 0). Kept as an autoload now so calls can be wired early without churn.

func play_music(_track: String, _fade: float = 1.0) -> void:
	pass

func play_ambient(_track: String) -> void:
	pass

func stop_all(_fade: float = 1.0) -> void:
	pass
