class_name Controller
extends Node

@export var target : Pawn

func _possess(target : Pawn) -> void:
	self.target = target
	
func _unpossess() -> void:
	target = null
