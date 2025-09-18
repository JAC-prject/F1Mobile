# ERS skeleton
extends Node
var charge=100.0
func deploy(x): charge=max(0,charge-x)
func regen(dt): charge=min(100,charge+dt*0.5)
