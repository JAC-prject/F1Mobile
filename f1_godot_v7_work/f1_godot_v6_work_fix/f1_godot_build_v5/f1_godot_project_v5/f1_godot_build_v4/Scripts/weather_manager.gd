# Weather skeleton
extends Node
enum W{SUN,LR,HR}
var current=W.SUN
func set_weather(w): current=w
func grip_mod(): return {W.SUN:1.0,W.LR:0.85,W.HR:0.7}[current]
