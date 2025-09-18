extends Node
@export var opponent_scene : PackedScene
@export var num_opponents : int = 23
@export var waypoint_root : NodePath
@export var skill_mean := 0.78
@export var skill_spread := 0.10
@export var aggressiveness_mean := 0.45
@export var aggressiveness_spread := 0.18
var rng = RandomNumberGenerator.new()
var opponents = []
func _ready():
    rng.randomize()
    _spawn_opponents()
func _spawn_opponents():
    var wp_root = null
    if has_node(waypoint_root):
        wp_root = get_node(waypoint_root)
    for i in range(num_opponents):
        if opponent_scene == null:
            continue
        var op = opponent_scene.instantiate()
        op.name = "AI_Opp_%02d" % (i+1)
        var skill = clamp(skill_mean + (rng.randf()-0.5)*skill_spread*2.0, 0.35, 0.99)
        var aggr = clamp(aggressiveness_mean + (rng.randf()-0.5)*aggressiveness_spread*2.0, 0.0, 1.0)
        if op.has_method("set"):
            op.set("skill_level", skill)
            op.set("aggressiveness", aggr)
        add_child(op)
        opponents.append({"node":op, "next_wp":0})
func _process(delta):
    for d in opponents:
        var car = d.node
        if car == null: continue
        var wp = null
        if has_node(waypoint_root):
            var wp_root = get_node(waypoint_root)
            if d.next_wp < wp_root.get_child_count():
                wp = wp_root.get_child(d.next_wp)
        if wp:
            var dir = (wp.global_transform.origin - car.global_transform.origin)
            var dist = dir.length()
            var forward = -car.global_transform.basis.z.normalized()
            var steer = clamp(forward.cross(dir.normalized()).y, -1, 1) * (1.0 - (car.get("skill_level") if car.has_method("get") else 0.5)*0.5)
            var accel = 1.0 * (car.get("skill_level") if car.has_method("get") else 0.7)
            if dist < 8.0:
                accel *= 0.6
            if dist < 3.5:
                d.next_wp = (d.next_wp + 1) % max(1, get_node(waypoint_root).get_child_count())
            var ahead = _find_car_ahead(car, 6.0)
            if ahead and (car.get("aggressiveness") if car.has_method("get") else 0.4) > 0.6:
                steer += 0.2 * (car.get("aggressiveness") if car.has_method("get") else 0.4)
            if car.has_method("apply_inputs"):
                car.apply_inputs(accel, 0.0, steer)
func _find_car_ahead(car, radius):
    for d in opponents:
        var other = d.node
        if other == car: continue
        var rel = other.global_transform.origin - car.global_transform.origin
        if rel.length() < radius and rel.dot(-car.global_transform.basis.z) > 0.0:
            return other
    return null
