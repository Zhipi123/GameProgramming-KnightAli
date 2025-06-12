extends "res://Scene/weapon.gd"  

func _ready():
	shootSpeed = 12.0  
	bullet_damage = 10
	super._ready()

func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()

		var bulletNode = BULLET.instantiate()
		bulletNode.set_direction(bulletDirection)
		bulletNode.damage = bullet_damage  

		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = marker_2d.global_position
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
		$Marker2D.position = Vector2(-65, 5)
		$Marker2D.rotation_degrees = 180

