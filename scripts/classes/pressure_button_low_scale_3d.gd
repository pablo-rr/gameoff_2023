class_name PressureButtonLowScale3D
extends PressureButton3D

@export var max_scale : float = 0.6

var button_pressed : bool = false
var bodies : Array[Node3D]

func press(body : Node3D) -> void:
	if(body.name != "Player"):
		var scalables : Array[Node] = Utils.find_custom_nodes(body, "res://scripts/classes/scalable_3d.gd")
		if(scalables.size() > 0):
			bodies.append(body)
			if((scalables[0] as Scalable3D).current_scale.x <= max_scale):
				button_pressed = true
				emit_signal("pressed")
				var p_tween : Tween = get_tree().create_tween()
				p_tween.tween_property($Button, "transform:origin:y", -0.05, 0.25)
				if((!sound_only_once) or (sound_only_once and !sound_played)):
					audio_stream.play()
		
func unpress(body : Node3D) -> void:
	if(body.name != "Player"):
		var scalables : Array[Node] = Utils.find_custom_nodes(body, "res://scripts/classes/scalable_3d.gd")
		if(scalables.size() > 0):
			bodies.erase(body)
			if((scalables[0] as Scalable3D).current_scale.x <= max_scale):
				button_pressed = false
				emit_signal("unpressed")
				var p_tween : Tween = get_tree().create_tween()
				p_tween.tween_property($Button, "transform:origin:y", 0.1, 0.25)
				
func _process(delta: float) -> void:
	if(!button_pressed):
		for body in bodies:
			var scalables : Array[Node] = Utils.find_custom_nodes(body, "res://scripts/classes/scalable_3d.gd")
			if(scalables.size() > 0):
				if((scalables[0] as Scalable3D).current_scale.x <= max_scale):
					button_pressed = true
					emit_signal("pressed")
					var p_tween : Tween = get_tree().create_tween()
					p_tween.tween_property($Button, "transform:origin:y", -0.05, 0.25)
	else:
		for body in bodies:
			var scalables : Array[Node] = Utils.find_custom_nodes(body, "res://scripts/classes/scalable_3d.gd")
			if(scalables.size() > 0):
				if((scalables[0] as Scalable3D).current_scale.x > max_scale):
					button_pressed = true
					emit_signal("unpressed")
					var p_tween : Tween = get_tree().create_tween()
					p_tween.tween_property($Button, "transform:origin:y", 0.1, 0.25)
