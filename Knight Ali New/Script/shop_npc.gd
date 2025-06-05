extends CharacterBody2D

@export var walk_speed: float = 50.0
@export var idle_left_animation: String = "idle_left"
@export var idle_right_animation: String = "idle_right"
@export var walk_left_animation: String = "walk_left"
@export var walk_right_animation: String = "walk_right"

var move_target: Vector2
var is_walking: bool = false
var is_moving_left: bool = false

# 区域的最小和最大值
var min_x: float = 45
var max_x: float = 777
var min_y: float = 300
var max_y: float = 545

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# 获取一个随机移动目标位置，在指定的矩形区域内
func get_random_move_target():
	var random_x = randf_range(min_x, max_x)  # 在指定的X范围内
	var random_y = randf_range(min_y, max_y)  # 在指定的Y范围内
	return Vector2(random_x, random_y)

func _ready():
	move_target = get_random_move_target()  # 初始时选择一个随机目标

func _process(delta):
	move_npc(delta)  # 移动NPC

# 移动 NPC 并处理碰撞
func move_npc(delta):
	var direction_to_target = (move_target - global_position).normalized()

	# 根据目标位置的方向计算新的速度
	velocity = direction_to_target * walk_speed

	# 执行平滑移动
	move_and_slide()

	# 播放走路动画
	play_walk_animation(direction_to_target)

	# 判断是否到达目标，达到时随机选择下一个目标
	if global_position.distance_to(move_target) < 10:
		move_target = get_random_move_target()  # 到达目标时，重新选择一个新的随机目标

# 播放走路动画
func play_walk_animation(direction_to_target: Vector2):
	if direction_to_target.x < 0:
		animated_sprite.play(walk_left_animation)
		is_moving_left = true
	else:
		animated_sprite.play(walk_right_animation)
		is_moving_left = false

# 播放静止动画
func play_idle_animation():
	if is_moving_left:
		animated_sprite.play(idle_left_animation)
	else:
		animated_sprite.play(idle_right_animation)

# 处理碰撞
func _on_area_entered(area):
	if area is CollisionPolygon2D:
		# 碰撞到区域后改变目标位置，使 NPC 向反方向走
		# 反转目标位置
		move_target = global_position - (move_target - global_position) * 2  # 反向计算新的目标位置
