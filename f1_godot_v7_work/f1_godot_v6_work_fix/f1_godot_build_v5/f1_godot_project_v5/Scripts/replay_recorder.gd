extends Node
var recording = false
var tracked_nodes = [] # array of NodePaths
var frames = [] # array of dictionaries per frame
func start_recording():
    recording = true
    frames.clear()
func stop_recording():
    recording = false
func track(node_path:NodePath):
    if not tracked_nodes.has(node_path):
        tracked_nodes.append(node_path)
func untrack(node_path:NodePath):
    tracked_nodes.erase(node_path)
func _physics_process(delta):
    if recording:
        var snap = {}
        for p in tracked_nodes:
            if has_node(p):
                var n = get_node(p)
                snap[str(p)] = n.global_transform
        frames.append(snap)
func get_frames():
    return frames
