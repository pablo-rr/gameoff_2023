class_name CollectibleCoin
extends Node3D

@export var rotator_active : bool = true

var ipos : PackedScene = preload("res://scenes/particle_effects/gem_taken.tscn")
var coin_sfx_data : AudioStream3DData = AudioStream3DData.new()

func _ready() -> void:
	($Rotator3D as Rotator3D).active = rotator_active

	
func _on_player_detect_area_3d_player_entered(player : SPPlayer3D) -> void:

	coin_sfx_data.pitch_scale = 1
	coin_sfx_data.volume_db = -8.0
	coin_sfx_data.max_db = -3.0
	coin_sfx_data.sound_start = 0
	Utils.play_3d_sound_at(load("res://art/sfx/collectibles/coinv2.mp3"), global_transform.origin, get_parent(), coin_sfx_data)
	(Persistance.persistance_data as PersistanceData).coin_recount += 1
	Persistance.save()
	var inst : GPUParticlesIPOS3D = ipos.instantiate()
	get_parent().add_child(inst)
	inst.global_transform = global_transform
	queue_free()
