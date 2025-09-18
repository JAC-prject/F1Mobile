extends CanvasLayer
# Simple mobile control mapper: requires node path to player car (set in editor)
@export var player_path : NodePath = NodePath("/root/Main/Player/PlayerCar")
onready var player = null
var steer_value = 0.0

func _ready():
    if has_node(player_path):
        player = get_node(player_path)
    # Connect TouchScreenButtons if present
    if $AccelButton:
        $AccelButton.pressed.connect(_on_accel_pressed)
        $AccelButton.released.connect(_on_accel_released)
    if $BrakeButton:
        $BrakeButton.pressed.connect(_on_brake_pressed)
        $BrakeButton.released.connect(_on_brake_released)
    if $DRSButton:
        $DRSButton.pressed.connect(_on_drs)
    if $ERSButton:
        $ERSButton.pressed.connect(_on_ers)

func _on_accel_pressed():
    if player and player.has_method("apply_inputs"):
        player.apply_inputs(1.0, 0.0, steer_value)

func _on_accel_released():
    if player and player.has_method("apply_inputs"):
        player.apply_inputs(0.0, 0.0, steer_value)

func _on_brake_pressed():
    if player and player.has_method("apply_inputs"):
        player.apply_inputs(0.0, 1.0, steer_value)

func _on_brake_released():
    if player and player.has_method("apply_inputs"):
        player.apply_inputs(0.0, 0.0, steer_value)

func _on_drs():
    # placeholder: emit signal or call race manager to enable DRS
    print("DRS toggled (mobile)")

func _on_ers():
    # placeholder: toggle ERS deployment
    print("ERS toggled (mobile)")

func _input(event):
    # Simple steering by dragging on SteerPad
    if event is InputEventScreenDrag or event is InputEventScreenTouch:
        var local = $SteerPad.get_local_mouse_position()
        var cx = $SteerPad.rect_size.x/2
        steer_value = clamp((local.x - cx) / cx, -1.0, 1.0)
        if player and player.has_method("apply_inputs"):
            # maintain accel/brake current state; naive: accel if accel button pressed
            var accel = $AccelButton.pressed if $AccelButton else 0.0
            var brake = $BrakeButton.pressed if $BrakeButton else 0.0
            player.apply_inputs(accel, brake, steer_value)
