

v5-complete update (I,II,III,IV applied):
- AIManager wired into main.tscn with AIManager.tscn; set opponent_scene to your car prefab if different.
- Auto.gd updated with apply_inputs(accel,brake,steer) to accept AI inputs.
- Replay UI (UI/ReplayUI.tscn) and scripts added; ReplayPlayer instance added to main.tscn at runtime path /root/Main/ReplayPlayer.
- basisu not available here; use basisu locally. README updated with commands.

To convert PNG to Basis (recommended):
basisu -q 1 Texturas/Autos/livery_01.png -output_file Texturas/Autos/livery_01.basis
basisu -q 1 Texturas/Circuitos/pista_01.png -output_file Texturas/Circuitos/pista_01.basis
