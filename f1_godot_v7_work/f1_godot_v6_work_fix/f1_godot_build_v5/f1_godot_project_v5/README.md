

v5 update: 'Haz todo' tasks applied:
- AI Manager: spawns 23 opponents with skill/aggressiveness and waypoint following + basic overtaking behavior (prototype).
- Pit Manager: pit stop timing, Timer-based sequence, emits pit_completed signal.
- Replay: recorder and player scripts added; can record transforms and playback sequentially.
- Attempted WAV->OGG conversion: ffmpeg not available or no conversions; run ffmpeg locally. See below.
- Helmet visors: created visor PNG overlays and updated pilot resources to reference visor_texture.

Please test AI tuning, integrate waypoints per track, hook AIManager.opponent_scene to your car scene, and wire ReplayRecorder.track() for cameras and cars to record. Use ffmpeg locally to convert WAV->OGG for smaller builds.
