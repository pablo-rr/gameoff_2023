class_name EnemySpawner3D
extends Spawner3D

@export var root : Node3D

func spawn() -> Node3D:
	var inst : EnemyBody3D = scene.instantiate()
	inst.player = Utils.get_player(root)
	get_parent().add_child(inst)
	inst.global_transform = global_transform
	return inst
