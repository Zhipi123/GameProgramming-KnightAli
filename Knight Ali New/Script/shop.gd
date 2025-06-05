extends Node2D

# 初始化商店场景
func _ready():
	global.current_scene = "ShopScene"  # 设置当前场景为商店
	print("Current Scene:", global.current_scene)
	print("Previous Scene:", global.previous_scene)  # 确保 previous_scene 被正确设置
	print("Next Scene:", global.next_scene)  # 确保 next_scene 被正确设置

	# 根据上一场景决定玩家的位置
	if global.previous_scene == "GrassScene":
		# 在新场景的 _ready 中设置玩家位置
		$player.position.x = global.player_come_shop_posx
		$player.position.y = global.player_come_shop_posy

func _process(delta):
	change_scene()  # 检查是否要切换场景

# 监听玩家进入商店并返回上一个场景
func _on_go_back_to_scene_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		if global.previous_scene == "GrassScene":
			global.next_scene = "res://Scene/Grass.tscn"

func _on_go_back_to_scene_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

# 场景切换逻辑
func change_scene():
	if global.transition_scene:
		global.previous_scene = "ShopScene"
		get_tree().change_scene_to_file(global.next_scene)  # 执行场景跳转
		global.finish_changescenes()  # 完成场景转换
