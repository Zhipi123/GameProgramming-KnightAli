extends "res://Script/enemy.gd"

@onready var marker1 = $Marker2D1
@onready var marker6 = $Marker2D2
@onready var marker5 = $Marker2D3
@onready var marker4 = $Marker2D4
@onready var marker3 = $Marker2D5
@onready var marker2 = $Marker2D6
@onready var shoot_speed_timer = $ShootSpeedTimer
@onready var spawn_timer = $SpawnTimer
var canShoot = true
var canSpawn = true


@export var shootSpeed: float = 10.0 
@export var bullet_damage: int = 10
var bulletDirection = Vector2(1, 0)  
const slime3 = preload("res://Scene/enemy/enemy_slime_3.tscn")
const BULLET = preload("res://Scene/enemy_bullet.tscn")

var directions = [
	Vector2(1, 0),              
	Vector2(0.5, 0.866).normalized(),  
	Vector2(-0.5, 0.866).normalized(), 
	Vector2(-1, 0),             
	Vector2(-0.5, -0.866).normalized(),
	Vector2(0.5, -0.866).normalized()  
]

func _ready():
	self.speed = 60
	self.idle_speed = 10
	self.health = 3000
	self.random_move_range = 40
	super._ready()

func get_random_move_target():
	var random_x = position.x + randf_range(-random_move_range, random_move_range)
	var random_y = position.y + randf_range(-random_move_range, random_move_range)
	return Vector2(random_x, random_y)

func _physics_process(delta):
	if is_dying:
		return

	if health > 2000:
		self.speed = 80 
		enemy_spawn()
	elif health < 2000:
		self.speed = 120
		enemy_shoot()
		enemy_spawn()
		
	var current_speed = idle_speed

	if player_chase and player:
		current_speed = speed
		var direction = (player.position - position).normalized()
		var move_vector = direction * current_speed * delta
		move_and_collide(move_vector)
		update_animation("chase", move_vector)
	else:
		var direction = (move_target - position).normalized()
		var move_vector = direction * current_speed * delta
		move_and_collide(move_vector)
		update_animation("move", move_vector)
		
		if position.distance_to(move_target) < 5:
			move_target = get_random_move_target()

	update_health()

		

func update_animation(state="idle", move_vector=Vector2.ZERO):
	if is_attack == true: 
		$AnimatedSprite2D.play("attack")
	else:
		$AnimatedSprite2D.play("idle")

func enemy():
	pass

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body == player:
		player_chase = false
		player = null

func get_damage(damage_amount):
	if is_dying:
		return
	health -= damage_amount
	print(health)
	if health <= 0:
		die()

func update_health():
	var healthbar = $health_bar
	healthbar.value = health
	if health >= 3000:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout():
	if health < 2000:
		health = health + 100
		if health > 2000:
			health = 2000
	if health <= 0:
		health = 0

func die():
	is_dying = true
	$AnimatedSprite2D.play("death")
	print("Enemy died!")
	global.kill_enemies +=1
	global.current_coins +=66666
	global.scene_enemy_count -=1
	await get_tree().create_timer(0.6).timeout 
	global.is_boss_dead = true
	queue_free()

func enemy_spawn():
	if canSpawn:
		canSpawn = false
		var slime_instance1 = slime3.instantiate()
		var slime_instance2 = slime3.instantiate()
		slime_instance1.global_position = position + Vector2(40, 0) 
		slime_instance2.global_position = position + Vector2(-40, 0) 
		get_tree().root.add_child(slime_instance1)
		get_tree().root.add_child(slime_instance2)
		global.scene_enemy_count += 2
		spawn_timer.start()

func enemy_shoot():
	if canShoot:
		canShoot = false
		var markers = [marker1, marker2, marker3, marker4, marker5, marker6]
		shoot_speed_timer.start()
		for i in range(markers.size()):
			var bulletNode = BULLET.instantiate()
			bulletNode.set_direction(directions[i]) 
			bulletNode.damage = bullet_damage
			get_tree().root.add_child(bulletNode)
			bulletNode.global_position = markers[i].global_position

func _on_shoot_speed_timer_timeout():
	canShoot = true
	enemy_shoot() 


func _on_spawn_timer_timeout():
	canSpawn = true
	enemy_spawn()
