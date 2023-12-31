class_name RayVisualizer3D
extends Node3D

@onready var audio : AudioStreamPlayer3D = $AudioStreamPlayer3D

var extra_scale : float = 1.0

func enable() -> void:
	$RayVisualizerParticles.emitting = true

func disable() -> void:
	$RayVisualizerParticles.emitting = false

#func enable() -> void:
#	var tween_s : Tween = get_tree().create_tween()
#	var tween_o : Tween = get_tree().create_tween()
#	tween_s.tween_property(self, "scale", Vector3.ONE * extra_scale, 0.2)
#	tween_o.tween_property(self, "transform:origin", Vector3(3.6 * extra_scale, 0.0, 0.0), 0.2)
#
#func disable() -> void:
#	var tween_s : Tween = get_tree().create_tween()
#	var tween_o : Tween = get_tree().create_tween()
#	tween_s.tween_property(self, "scale", Vector3.ZERO, 0.2)
#	tween_o.tween_property(self, "transform:origin", Vector3(0.6 * extra_scale, 0.0, 0.0), 0.2)
