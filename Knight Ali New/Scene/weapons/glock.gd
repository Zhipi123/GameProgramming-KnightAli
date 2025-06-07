extends "res://Scene/weapon.gd"

func _ready():
	shootSpeed = 4.0
	bullet_damage = 8
	super._ready()

func apply_direction_settings(dir: String) -> void:
	if dir == "right":
		scale.x = 1
		position.x = 30  
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$Marker2D.position = Vector2(45, -6)  
		$Marker2D.rotation_degrees = 0

	elif dir == "left":
		scale.x = -1
		position.x = -30 
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = true
		$Marker2D.position = Vector2(-40, 6)
		$Marker2D.rotation_degrees = 180
