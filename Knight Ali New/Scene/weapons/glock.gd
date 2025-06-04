extends "res://Scene/weapon.gd"

func _ready():
	shootSpeed = 4.0
	bullet_damage = 8
	super._ready()# Glock 射速较快，可根据需要调整

func apply_direction_settings(dir: String) -> void:
	if dir == "right":
		scale.x = 1
		position.x = 30  # Glock 枪体较短，向右偏移小
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = false
		$Marker2D.position = Vector2(45, -6)  # 枪口稍短
		$Marker2D.rotation_degrees = 0

	elif dir == "left":
		scale.x = -1
		position.x = -30  # 向左偏移略小
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.flip_v = true
		$Marker2D.position = Vector2(-40, 6)
		$Marker2D.rotation_degrees = 180
