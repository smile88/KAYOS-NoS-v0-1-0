# Project Key Facts

### Project Layout and Config
- **Main World Scene**: `res://threed/StarfallCity3D.tscn`
- **Backup Scene**: `res://threed/StarfallCity3D_procedural_backup.tscn` (Use if the main scene gets bloated with baked greyboxes).
- **Asset Path**: `res://assets/` (e.g. `res://assets/environment_models/misc_background/`)

### Systems
- **Legacy Ledger UI**: Added in `res://ui/LegacyLedgerUI.tscn` (press `L` to toggle).
- **Quest Log UI**: Added in `res://ui/QuestLogUI.tscn` (press `J` or `Tab` to toggle).
- **Strain FX**: Post-processing shader in `res://threed/StrainFX.tscn` reacting to `GameState.mental_strain`.
- **Class Verbs**: 2D/3D Interactables gate hints behind `required_class_verb`.
