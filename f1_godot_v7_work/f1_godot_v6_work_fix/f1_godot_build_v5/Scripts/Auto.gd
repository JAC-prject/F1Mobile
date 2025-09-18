extends CharacterBody3D
@export var velocidad_max = 220.0
@export var aceleracion = 60.0
@export var freno = 80.0
@export var giro = 2.2
var velocidad_actual = 0.0
# inputs that can be set by player or AI
var input_acc = 0.0
var input_brake = 0.0
var input_steer = 0.0
func _physics_process(delta):
    # apply inputs to physics
    velocidad_actual += input_acc * aceleracion * delta
    if input_acc <= 0 and input_brake <= 0:
        velocidad_actual = max(velocidad_actual - freno * delta * 0.5, 0)
    # braking stronger
    velocidad_actual = max(velocidad_actual - input_brake * freno * delta, 0)
    velocidad_actual = clamp(velocidad_actual, 0, velocidad_max)
    if velocidad_actual > 1.0:
        rotate_y(-input_steer * giro * delta)
    var dir = -transform.basis.z
    velocity = dir * velocidad_actual * 0.1
    move_and_slide()
func get_speed_kmh():
    return int(velocidad_actual)
func apply_inputs(accel, brake, steer):
    input_acc = clamp(accel, 0.0, 1.0)
    input_brake = clamp(brake, 0.0, 1.0)
    input_steer = clamp(steer, -1.0, 1.0)
