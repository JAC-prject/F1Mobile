extends Node
signal pit_completed(car)
@export var pit_time_base = 6.0 # base seconds for tire change
func request_pit(car):
    # simulate pit stop timing and disable inputs if car supports it
    if car and car.has_method("apply_inputs"):
        # set a property to disable inputs (car script should respect this flag)
        if car.has_method("set"):
            car.set("input_disabled", true)
        # attempt to pause engine sounds or similar here
    var t = pit_time_base + randf() * 2.0
    var tm = Timer.new()
    tm.one_shot = true
    tm.wait_time = t
    add_child(tm)
    tm.start()
    tm.connect("timeout", Callable(self, "_on_pit_done").bind(car))
func _on_pit_done(car):
    # re-enable inputs
    if car and car.has_method("set"):
        car.set("input_disabled", false)
    emit_signal("pit_completed", car)
    print("PitManager: pit done for", car.name)
