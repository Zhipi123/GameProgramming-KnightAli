extends "res://Script/enemy_spawner.gd" 

func spawn_enemy(position: Vector2):
	global.scene_enemy_count +=1
	var enemy_scene : PackedScene
	if randf() > 0.5:
		enemy_scene = enemy_slime_1_scene  
	else:
		enemy_scene = enemy_skeleton_scene 
	
	if enemy_scene:  
		var enemy = enemy_scene.instantiate() 
		enemy.position = position  
		get_parent().add_child.call_deferred(enemy)  
	else:
		print("error")
		
	
