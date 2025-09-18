extends Node
var frames = []
var playing = false
var index = 0
func load_frames(f):
    frames = f
func play():
    if frames.empty(): return
    playing = true
    index = 0
    set_process(true)
func stop():
    playing = false
    set_process(false)
func _process(delta):
    if not playing: return
    if index >= frames.size():
        stop()
        return
    var snap = frames[index]
    for key in snap.keys():
        if has_node(key):
            var n = get_node(key)
            n.global_transform = snap[key]
    index += 1
