extends "res://Scene/weapon.gd"  # 指向 weapon.gd 的路径

func _ready():
	shootSpeed = 15.0  # 或 M4A1 的自定义属性
	bullet_damage = 15
	super._ready()

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
		$Marker2D.position = Vector2(-80, 8)
		$Marker2D.rotation_degrees = 180

