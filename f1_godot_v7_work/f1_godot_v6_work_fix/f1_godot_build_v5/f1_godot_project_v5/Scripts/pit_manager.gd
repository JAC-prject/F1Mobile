extends Node
signal pit_completed(car)
@export var pit_time_base = 6.0 # base seconds for tire change
func request_pit(car):
    # simulate pit stop timing and notify when done
    var t = pit_time_base + randf() * 2.0
    print("PitManager: starting pit for", car.name, "expected:", t)
    # In real project, you'd animate pit crew and block car movement. Here we emit after timer.
    var tm = Timer.new()
    tm.one_shot = true
    tm.wait_time = t
    add_child(tm)
    tm.start()
    tm.connect("timeout", Callable(self, "_on_pit_done").bind(car))
func _on_pit_done(car):
    emit_signal("pit_completed", car)
    print("PitManager: pit done for", car.name)
