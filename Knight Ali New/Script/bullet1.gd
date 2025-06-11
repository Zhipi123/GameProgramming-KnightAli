extends Area2D

@export var speed = 800
@export var damage = 15

var direction: Vector2

func _ready():
	if global.current_scene == "HomeScene":
		scale = Vector2(1, 1)
	elif global.current_scene == "GrassScene" or global.current_scene == "SnowScene":
		scale = Vector2(0.69, 0.69)
	await get_tree().create_timer(1.3).timeout
	queue_free()

func set_direction(bulletDirection):
	direction = bulletDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
func _physics_process(delta):
	global_position += direction*speed*delta

func _on_body_entered(body):
	if body.has_method("enemy"):
		body.get_damage(damage)
		queue_free()
	elif body is StaticBody2D or body is CharacterBody2D:
		queue_free()

