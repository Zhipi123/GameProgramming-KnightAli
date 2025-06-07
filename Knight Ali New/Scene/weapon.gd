extends Node2D

@export var shootSpeed: float = 1.0         
@export var bullet_damage: int = 10         

var aim_direction = Vector2.RIGHT
var bulletDirection = Vector2(1, 0)
var canShoot = true

const BULLET = preload("res://Scene/bullet1.tscn")

@onready var marker_2d = $Marker2D
@onready var shoot_speed_timer = $ShootSpeedTimer

func _ready():
	shoot_speed_timer.wait_time = 1 / shootSpeed

func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()

		var bulletNode = BULLET.instantiate()
		bulletNode.set_direction(bulletDirection)
		bulletNode.damage = bullet_damage  

		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = marker_2d.global_position

func _on_shoot_speed_timer_timeout():
	canShoot = true

func setup_direction(direction: Vector2):
	bulletDirection = direction.normalized()

func apply_direction_settings(dir: String) -> void:
	pass
