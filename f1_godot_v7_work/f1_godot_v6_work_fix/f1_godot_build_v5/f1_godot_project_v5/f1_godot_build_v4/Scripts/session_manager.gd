# Session manager
extends Node
enum S{FP1,FP2,FP3,Q1,Q2,Q3,RACE}
var cur=S.FP1
func start(s,d): cur=s
