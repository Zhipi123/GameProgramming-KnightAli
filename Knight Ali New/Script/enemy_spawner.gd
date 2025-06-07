extends Node2D

var enemy_slime_scene : PackedScene = preload("res://Scene/enemy/enemy_slime_1.tscn")
var enemy_skeleton_scene : PackedScene = preload("res://Scene/enemy/enemy_skeleton.tscn")

func _ready():
	spawn_enemy(position)
	spawn_enemy(position + Vector2(20, 0))

func _process(delta):
	pass

func _on_spawn_gap_timeout():
	spawn_enemy(position) 
	spawn_enemy(position + Vector2(20, 0))

func spawn_enemy(position: Vector2):
	var enemy_scene : PackedScene
	if randf() > 0.5:
		enemy_scene = enemy_slime_scene  
	else:
		enemy_scene = enemy_skeleton_scene 
	
	if enemy_scene:  
		var enemy = enemy_scene.instantiate() 
		enemy.position = position  
		get_parent().add_child.call_deferred(enemy)  
	else:
		print("error")
