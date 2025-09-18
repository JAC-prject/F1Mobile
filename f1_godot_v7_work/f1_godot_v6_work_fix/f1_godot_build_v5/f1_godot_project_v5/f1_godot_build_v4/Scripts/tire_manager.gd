# Tire manager skeleton
extends Node
enum C{SOFT,MED,HARD,INTER,WET}
class Tire:
	var comp=C.MED
	var wear=0.0
	func tick(dist): wear+=dist*0.0001
