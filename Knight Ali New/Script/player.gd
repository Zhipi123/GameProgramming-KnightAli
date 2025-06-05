extends CharacterBody2D

var speed = 100
var health = 100
var player_alive = true
var current_direction = "none"

var weapon: Node2D = null  # 由 equip_weapon 加载
var weapon_scene: PackedScene = preload("res://Scene/weapons/m4a1.tscn")  # 默认武器

var is_shooting = false
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var shoot_cooldown = 0.0
const SHOOT_COOLDOWN_DURATION = 0.5

var previous_direction = "none"

func _ready():
	health = global.player_health
	equip_weapon(weapon_scene)

func equip_weapon(scene: PackedScene):
	if weapon:
		weapon.queue_free()
	
	weapon = scene.instantiate()
	$weapon_holder.add_child(weapon)
	weapon.position = Vector2.ZERO

func _process(delta):
	global.player_health = health  # 保持全局生命值
	# 相机设置
	if global.current_scene == "HomeScene":
		$Camera2D.zoom = Vector2(1.75, 1.75)
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1140
		$Camera2D.limit_bottom = 640
		speed = 300
	elif global.current_scene == "GrassScene":
		$Camera2D.zoom = Vector2(2.3, 2.3)
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1150
		$Camera2D.limit_bottom = 640
		speed = 150
	elif global.current_scene == "ShopScene":
		$Camera2D.zoom = Vector2(1.7, 1.7)
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1140
		$Camera2D.limit_bottom = 640
		speed = 300
	update_health()
	is_shooting = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	if is_shooting:
		shoot_cooldown = SHOOT_COOLDOWN_DURATION
	elif shoot_cooldown > 0.0:
		shoot_cooldown -= delta

	if is_shooting or velocity == Vector2.ZERO or shoot_cooldown > 0.0:
		update_facing_by_mouse()

	if current_direction != previous_direction:
		reset_weapon_angle()
		previous_direction = current_direction

	update_weapon_aim()

func _physics_process(delta):
	var input_vector = player_movement(delta)
	on_attack()
	if health <= 0:
		player_alive = false
		health = 0
		print("player died!")
		queue_free()

	if is_shooting and weapon:
		weapon.setup_direction(weapon.aim_direction)
		weapon.shoot()

func player_movement(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
		if not is_shooting and shoot_cooldown <= 0.0:
			current_direction = "right"
	elif Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
		if not is_shooting and shoot_cooldown <= 0.0:
			current_direction = "left"

	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		play_animation(1)
	else:
		velocity = Vector2.ZERO
		play_animation(0)

	move_and_slide()
	return input_vector

func update_facing_by_mouse():
	var mouse_pos = get_global_mouse_position()
	current_direction = "right" if mouse_pos.x >= global_position.x else "left"

func reset_weapon_angle():
	if not weapon:
		return
	if current_direction == "right":
		weapon.rotation_degrees = 0
	elif current_direction == "left":
		weapon.rotation_degrees = 180

func play_animation(movement):
	var anim = $AnimatedSprite2D

	if current_direction == "right":
		anim.play("walkright_girl" if movement == 1 else "idle_girl_right")
	elif current_direction == "left":
		anim.play("walkleft_girl" if movement == 1 else "idle_girl_left")

	# 让武器自己处理朝向、位置、翻转等
	if weapon and weapon.has_method("apply_direction_settings"):
		weapon.apply_direction_settings(current_direction)

func update_weapon_aim():
	if not weapon:
		return

	var mouse_pos = get_global_mouse_position()
	var weapon_pos = weapon.global_position
	var to_mouse = (mouse_pos - weapon_pos).normalized()
	var angle_deg = rad_to_deg(to_mouse.angle())

	if (current_direction == "right" and (angle_deg < -90 or angle_deg > 90)) or (current_direction == "left" and (angle_deg > -90 and angle_deg < 90)):
		return

	weapon.rotation_degrees = angle_deg
	weapon.aim_direction = to_mouse

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func on_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health -= 10
		enemy_attack_cooldown = false
		$on_attack_cooldown.start()
		print(health)

func _on_on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func player():
	pass

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
