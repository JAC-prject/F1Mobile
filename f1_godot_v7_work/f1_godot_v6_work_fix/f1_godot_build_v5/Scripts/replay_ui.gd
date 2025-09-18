extends Control
onready var player = get_node_or_null("/root/Main/ReplayPlayer")
func _ready():
    $PlayButton.pressed.connect(_on_play)
    $StopButton.pressed.connect(_on_stop)
func _on_play():
    if player:
        player.play()
func _on_stop():
    if player:
        player.stop()
