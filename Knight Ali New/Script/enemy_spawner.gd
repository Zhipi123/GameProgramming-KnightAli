extends Node2D

var enemy_slime_1_scene : PackedScene = preload("res://Scene/enemy/enemy_slime_1.tscn")
var enemy_slime_2_scene : PackedScene = preload("res://Scene/enemy/enemy_slime_2.tscn")
var enemy_skeleton_scene : PackedScene = preload("res://Scene/enemy/enemy_skeleton.tscn")
var enemy_angel_scene : PackedScene = preload("res://Scene/enemy/enemy_angel.tscn")

func _ready():
	await get_tree().create_timer(2.0).timeout
	spawn_enemy(position)
	spawn_enemy(position + Vector2(20, 0))

func _process(delta):
	pass

func _on_spawn_gap_timeout():
	if global.scene_enemy_count <=25:
		spawn_enemy(position) 
		spawn_enemy(position + Vector2(20, 0))

func spawn_enemy(position: Vector2):
	pass
