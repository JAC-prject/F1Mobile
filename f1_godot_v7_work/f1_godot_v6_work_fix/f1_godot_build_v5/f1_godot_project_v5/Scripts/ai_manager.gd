extends Node
@export var opponent_scene : PackedScene
@export var num_opponents : int = 23
@export var waypoint_root : NodePath
var opponents = []
var rng = RandomNumberGenerator.new()
func _ready():
    rng.randomize()
    _spawn_opponents()
func _spawn_opponents():
    for i in range(num_opponents):
        var op = opponent_scene.instantiate()
        op.name = "AI_Opp_%02d" % (i+1)
        op.set("skill_level", rng.randf_range(0.4, 1.0))
        op.set("aggressiveness", rng.randf_range(0.0, 1.0))
        add_child(op)
        opponents.append({"node":op, "next_wp":0})
func _process(delta):
    for d in opponents:
        var car = d.node
        if car == null: continue
        var wp = _get_waypoint(d.next_wp)
        if wp:
            var dir = (wp.global_transform.origin - car.global_transform.origin)
            var dist = dir.length()
            var forward = -car.global_transform.basis.z.normalized()
            var steer = clamp(forward.cross(dir.normalized()).y, -1, 1) * (1.0 - car.get("skill_level")*0.5)
            var accel = 1.0 * car.get("skill_level")
            # braking based on corner sharpness (simple heuristic)
            if dist < 8.0:
                accel *= 0.6 * car.get("skill_level")
            if dist < 3.5:
                d.next_wp = (d.next_wp + 1) % max(1, get_node(waypoint_root).get_child_count())
            # basic overtaking: if slower car ahead and aggressiveness high, attempt slight steering offset
            var ahead = _find_car_ahead(car, 6.0)
            if ahead and car.get("aggressiveness") > 0.6 and car.get("skill_level")>0.6:
                steer += 0.2 * (car.get("aggressiveness"))
            if car.has_method("apply_inputs"):
                car.apply_inputs(accel, 0.0, steer)
func _get_waypoint(idx):
    if has_node(waypoint_root):
        var wp_root = get_node(waypoint_root)
        if idx < wp_root.get_child_count():
            return wp_root.get_child(idx)
    return null
func _find_car_ahead(car, radius):
    for d in opponents:
        var other = d.node
        if other == car: continue
        var rel = other.global_transform.origin - car.global_transform.origin
        if rel.length() < radius and rel.dot(-car.global_transform.basis.z) > 0.0:
            return other
    return null
