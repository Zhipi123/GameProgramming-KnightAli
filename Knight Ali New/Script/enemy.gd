extends CharacterBody2D

var speed = 80
var idle_speed = 40
var player_chase = false
var player = null
var health = 100
var random_move_range = 50
var move_target = Vector2.ZERO
var is_dying = false

func get_random_move_target():
	var random_x = position.x + randf_range(-random_move_range, random_move_range)
	var random_y = position.y + randf_range(-random_move_range, random_move_range)
	return Vector2(random_x, random_y)

func _ready():
	move_target = get_random_move_target()

func _physics_process(delta):
	if is_dying:
		return

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

func die():
	is_dying = true
	$AnimatedSprite2D.play("death")
	print("Enemy died!")

	await get_tree().create_timer(0.6).timeout 
	queue_free()

func update_health():
	var healthbar = $health_bar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func _on_regin_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
