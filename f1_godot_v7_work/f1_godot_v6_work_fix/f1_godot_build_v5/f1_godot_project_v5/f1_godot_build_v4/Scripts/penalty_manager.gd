# Penalty manager
extends Node
signal applied(car,type,duration)
func apply_penalty(car,type,duration):
	emit_signal("applied",car,type,duration)
