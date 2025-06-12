extends "res://Scene/weapon.gd"  

func _ready():
	shootSpeed = 15.0  
	bullet_damage = 15
	super._ready()
	
func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()

		var bulletNode1 = BULLET.instantiate()
		var bulletNode2 = BULLET.instantiate()
		var bulletNode3 = BULLET.instantiate()
		var bulletNode4 = BULLET.instantiate()
		var bulletNode5 = BULLET.instantiate()
		
		bulletNode1.set_direction(bulletDirection)
		bulletNode1.damage = bullet_damage  
		bulletNode2.set_direction(bulletDirection)
		bulletNode2.damage = bullet_damage
		bulletNode3.set_direction(bulletDirection)
		bulletNode3.damage = bullet_damage  
		bulletNode4.set_direction(bulletDirection)
		bulletNode4.damage = bullet_damage
		bulletNode5.set_direction(bulletDirection)
		bulletNode5.damage = bullet_damage 
		
		get_tree().root.add_child(bulletNode1)
		get_tree().root.add_child(bulletNode2)
		get_tree().root.add_child(bulletNode3)
		get_tree().root.add_child(bulletNode4)
		get_tree().root.add_child(bulletNode5)
		
		bulletNode1.global_position = marker_2d.global_position + Vector2(0, -14) 
		bulletNode2.global_position = marker_2d.global_position + Vector2(0, -7) 
		bulletNode3.global_position = marker_2d.global_position + Vector2(0, 0) 
		bulletNode4.global_position = marker_2d.global_position + Vector2(0, 7)
		bulletNode5.global_position = marker_2d.global_position + Vector2(0, 14)  
		$AudioStreamPlayer2D.play()
		
func apply_direction_settings(dir: String) -> void:
	if dir == "right":
		scale.x = 1
		position.x = 30
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$Marker2D.position = Vector2(60, 0)
		$Marker2D.rotation_degrees = 0
	elif dir == "left":
		scale.x = -1
		position.x = -35
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = true
		$Marker2D.position = Vector2(-70,10)
		$Marker2D.rotation_degrees = 180

