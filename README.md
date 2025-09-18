

Android build instructions:
- Open this project in Godot 4 on your PC.
- Install Android SDK/NDK and configure export templates in Godot.
- In Export > Add 'Android' preset, or use provided export_presets.cfg.
- Before export: convert textures to ETC2/ASTC (use basisu) and audio to OGG (ffmpeg).
- Set Run/Main Scene to res://main.tscn and enable Release export.
- Sign the APK with your keystore.
- Recommended device test: Android 8+ with ETC2 support.
