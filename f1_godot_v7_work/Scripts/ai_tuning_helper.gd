extends Node
# Simple AI tuning helper: given waypoints and a car prefab, simulates lap times using skill modifiers
# This is not a physics simulation — it's a heuristic estimator to suggest skill_mean/ spread adjustments.
func estimate_lap_time(waypoints_count, base_time_seconds=90.0, skill_mean=0.78):
    # base_time is an estimate for an average skill 0.78 car on this track
    var modifier = 1.0 - (skill_mean - 0.7) * 0.25
    var lap_time = base_time_seconds * modifier * (1.0 + (200.0 - waypoints_count)/1000.0)
    return lap_time
func suggest_skill_adjustments(target_race_time, waypoints_count):
    var base = estimate_lap_time(waypoints_count)
    var diff = target_race_time - base
    var adjust = -diff / base * 0.5
    return clamp(0.78 + adjust, 0.5, 0.95)
