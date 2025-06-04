extends CharacterBody2D

var speed = 80  # 追逐玩家的速度
var idle_speed = 40  # 随机移动时的速度
var player_chase = false
var player = null
var health = 100
var random_move_range = 50  # 怪物随机移动的范围
var move_target = Vector2.ZERO  # 随机移动的目标位置

# 在怪物周围生成随机位置
func get_random_move_target():
	var random_x = position.x + randf_range(-random_move_range, random_move_range)
	var random_y = position.y + randf_range(-random_move_range, random_move_range)
	return Vector2(random_x, random_y)

func _ready():
	move_target = get_random_move_target()  # 初始生成一个随机目标

func _physics_process(delta):
	var current_speed = idle_speed  # 默认使用随机移动的速度

	if player_chase and player:
		# 玩家追逐模式
		current_speed = speed  # 追逐玩家时使用更快的速度
		var direction = (player.position - position).normalized()  # 朝向玩家的方向
		var move_vector = direction * current_speed * delta  # 计算每帧的移动步长

		# 使用 move_and_collide 来处理碰撞
		move_and_collide(move_vector)  # 使用物理引擎处理碰撞
		update_animation("chase")  # 更新敌人动画为追逐状态
	else:
		# 随机移动模式
		var direction = (move_target - position).normalized()  # 朝向目标位置的方向
		var move_vector = direction * current_speed * delta  # 计算每帧的移动步长

		move_and_collide(move_vector)  # 使用物理引擎处理碰撞
		update_animation("move")  # 更新敌人动画为随机移动状态

		# 如果怪物接近目标位置，则更新新的随机目标
		if position.distance_to(move_target) < 5:  # 如果接近目标位置，更新随机目标
			move_target = get_random_move_target()

	# 检查敌人与玩家的相对位置，更新动画
	update_animation()

func update_animation(state="idle"):
	if velocity.length() < 0.1:
		$AnimatedSprite2D.play("idle")
	else:
		if state == "chase":
			if abs(velocity.x) > abs(velocity.y):
				if velocity.x > 0:
					$AnimatedSprite2D.play("walk_right")
				else:
					$AnimatedSprite2D.play("walk_left")
			else:
				if velocity.y > 0:
					$AnimatedSprite2D.play("walk_down")
				else:
					$AnimatedSprite2D.play("walk_up")
		elif state == "move":
			if abs(velocity.x) > abs(velocity.y):
				if velocity.x > 0:
					$AnimatedSprite2D.play("walk_right")
				else:
					$AnimatedSprite2D.play("walk_left")
			else:
				if velocity.y > 0:
					$AnimatedSprite2D.play("walk_down")
				else:
					$AnimatedSprite2D.play("walk_up")
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
	health -= damage_amount
	print(health)
	if health <= 0:
		die()

func die():
	$AnimatedSprite2D.play("death")
	print("Enemy died!")
	queue_free()
