extends Node2D

@export var shootSpeed = 1.0
var aim_direction = Vector2.RIGHT

const BULLET = preload("res://Scene/bullet1.tscn")

@onready var marker_2d = $Marker2D
@onready var shoot_speed_timer = $ShootSpeedTimer

var canShoot = true

var bulletDirection = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_speed_timer.wait_time = 0.05 / shootSpeed

func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		
		var bulletNode = BULLET.instantiate()
		
		bulletNode.set_direction(bulletDirection)
		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = marker_2d.global_position
		



func _on_shoot_speed_timer_timeout():
	canShoot = true

func setup_direction(direction):
	bulletDirection = direction.normalized()

