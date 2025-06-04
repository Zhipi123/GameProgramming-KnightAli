extends CharacterBody2D

var speed = 100
var health = 150
var player_alive = true
var current_direction = "none"
@onready var weapon = $weapon

var is_shooting = false
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var shoot_cooldown = 0.0
const SHOOT_COOLDOWN_DURATION = 0.5

var previous_direction = "none"  # 用于检测是否发生方向切换

func _ready():
	pass

func _process(delta):
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
		
	is_shooting = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	# 设置射击后的锁定时间
	if is_shooting:
		shoot_cooldown = SHOOT_COOLDOWN_DURATION
	elif shoot_cooldown > 0.0:
		shoot_cooldown -= delta

	# 控制朝向：静止 / 射击中 / 射击后延迟中
	if is_shooting or velocity == Vector2.ZERO or shoot_cooldown > 0.0:
		update_facing_by_mouse()

	# 如果朝向发生变化，重置枪的角度，避免翻转
	if current_direction != previous_direction:
		reset_weapon_angle()
		previous_direction = current_direction

	update_weapon_aim()

func _physics_process(delta):
	var input_vector = player_movement(delta)
	on_attack()
	if health <=0 :
		player_alive = false #添加结束动画
		health = 0
		print("player died!")
		self.queue_free()
		
	if is_shooting:
		weapon.setup_direction(weapon.aim_direction)
		weapon.shoot()

func player():
	pass

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
	if mouse_pos.x >= global_position.x:
		current_direction = "right"
	else:
		current_direction = "left"

func reset_weapon_angle():
	if current_direction == "right":
		weapon.rotation_degrees = 0
	elif current_direction == "left":
		weapon.rotation_degrees = 180

func play_animation(movement):
	var anim = $AnimatedSprite2D

	if current_direction == "right":
		if movement == 1:
			anim.play("walkright_girl")
		else:
			anim.play("idle_girl_right")
	elif current_direction == "left":
		if movement == 1:
			anim.play("walkleft_girl")
		else:
			anim.play("idle_girl_left")

	# 武器根据当前朝向控制显示
	if current_direction == "right":
		$weapon.scale.x = 1
		$weapon.position.x = 30
		$weapon/AnimatedSprite2D.flip_h = false
		$weapon/AnimatedSprite2D.flip_v = false
		$weapon/Marker2D.position.x = 60  # 设置合适的x值（向右）
		$weapon/Marker2D.position.y = 0
		$weapon/Marker2D.rotation_degrees = 0  # 保持朝右

	elif current_direction == "left":
		$weapon.scale.x = -1
		$weapon.position.x = -35
		$weapon/AnimatedSprite2D.flip_h = true
		$weapon/AnimatedSprite2D.flip_v = true
		$weapon/Marker2D.position.x = -80 # 设置合适的x值（向左）
		$weapon/Marker2D.position.y = 8
		$weapon/Marker2D.rotation_degrees = 180  # 镜像翻转


func update_weapon_aim():
	var mouse_pos = get_global_mouse_position()
	var weapon_pos = weapon.global_position
	var to_mouse = (mouse_pos - weapon_pos).normalized()

	var angle = to_mouse.angle()
	var angle_deg = rad_to_deg(angle)

	# 限制枪口旋转范围，避免鼠标在背后造成翻转
	if current_direction == "right":
		if angle_deg < -90 or angle_deg > 90:
			return
	elif current_direction == "left":
		if angle_deg > -90 and angle_deg < 90:
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
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$on_attack_cooldown.start()
		print(health)


func _on_on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
