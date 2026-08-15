# Project Bugs and Solutions

### 2026-08-15 - Procedural GLB Meshes Spawning Microscopic and Sunk
- **Issue**: Dynamically loaded `.glb` models were invisible because `scale` was defaulted to `1.0` (too small) and they were sunk halfway into the floor because their origins were centered. Also, previous greybox instances were permanently baked into the `.tscn` file due to being saved in Editor.
- **Root Cause**: `.glb` assets were built with 1 unit != 1 meter (needed ~30x scale) and centered pivots instead of bottom pivots.
- **Solution**: Added `BASE_GLB_SCALE = 30.0` constant in `StarfallCity3D.gd`. Wrote `_snap_to_ground` using `get_global_transform` and `aabb.get_endpoint()` to calculate lowest physical point and snap it to Y=0. Restored `StarfallCity3D_procedural_backup.tscn` to strip saved greybox collision nodes.
- **Prevention**: In future, don't open and save procedural `StarfallCity3D.tscn` directly in Godot editor without checking `is_baked` flag to clear geometry, otherwise `@tool` nodes get saved permanently. Ensure `.glb` origins are at the bottom for new assets, or continue using `_snap_to_ground`.

### 2026-08-15 - InputMap Error Spam from UI
- **Issue**: `InputMap` action errors flooded the headless test and the runtime because `toggle_legacy_ledger` and `quest_log` actions did not exist in the Godot `ProjectSettings`.
- **Root Cause**: Scripts blindly called `event.is_action_pressed()` without verifying if the project settings actually had them mapped.
- **Solution**: Wrapped the event checks in `InputMap.has_action("...")` checks inside `_unhandled_input()`.
- **Prevention**: Always use `InputMap.has_action()` before querying for specific dynamically-added keybindings if they aren't guaranteed to be present.
