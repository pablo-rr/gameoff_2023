class_name Stompable3D
extends Node3D

signal stomped

@export var enemy : EnemyBody3D
@export var player_detector : PlayerDetectArea3D
@export var death_impulse : float = 9.0
@export_category("Scale")
@export var scalable : Scalable3D
@export var vulnerable_scale : Vector3 = Vector3(0.5, 0.5, 0.5)
@export_category("Vulnerabilities")
@export var vulnerable_radius : float = 1.0

var explosion : PackedScene = preload("res://scenes/particle_effects/smoke.tscn")

func stomp() -> void:
	enemy.alive = false
	enemy.collision_shape.queue_free()
	enemy.stun(100.0)
	enemy.velocity.y = 0.0
	var tween_s : Tween = get_tree().create_tween()
	tween_s.tween_property(enemy.get_node("Mesh").get_child(0), "scale", Vector3(enemy.get_node("Mesh").get_child(0).scale.x, 0, enemy.get_node("Mesh").get_child(0).scale.z), 0.23)
	
	tween_s.finished.connect(Callable(func() -> void:
		await get_tree().create_timer(0.5).timeout
		var inst : GPUParticlesIPOS3D = explosion.instantiate()
		enemy.get_parent().add_child(inst)
		inst.global_transform.origin = global_transform.origin
		enemy.queue_free()
	))

func _ready() -> void:
	player_detector.player_entered.connect(Callable(func(player : SPPlayer3D) -> void:
		if(player.global_transform.origin.y > global_transform.origin.y):
#		and Utils.between(player.global_transform.origin.x, global_transform.origin.x - (vulnerable_radius / 2), global_transform.origin.x + (vulnerable_radius / 2))
#		and Utils.between(player.global_transform.origin.z, global_transform.origin.z - (vulnerable_radius / 2), global_transform.origin.z + (vulnerable_radius / 2))
			if(!enemy.alive) : return
			if(scalable == null or (scalable != null and scalable.current_scale.x <= vulnerable_scale.x)):
				player.velocity.y = death_impulse
				player.move_and_slide()
				
				stomp()
		
		else:
			if(!enemy.alive) : return
			enemy.velocity.y = 3.0
			enemy.move_and_slide()
			enemy.stun()
			
			var force : Vector3 = (enemy.global_transform.origin - player.global_transform.origin).normalized()
			player.velocity.y = death_impulse / 3
			player.move_and_slide()
			player.jump_external_force = Vector2(force.x, force.z) * 3
			player.health_system.damage(1)
	))
