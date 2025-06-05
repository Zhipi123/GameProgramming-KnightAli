extends Node2D

func _ready():
	global.current_scene = "GrassScene"
	print(global.current_scene)
	print(global.previous_scene)
	print(global.next_scene)

	# 根据上一场景决定玩家的位置
	if global.previous_scene == "HomeScene":
		$player.position.x = global.grass_to_home_posx
		$player.position.y = global.grass_to_home_posy
	elif global.previous_scene == "ShopScene":
		$player.position.x = global.grass_to_shop_posx
		$player.position.y = global.grass_to_shop_posy

func _process(delta):
	change_scene()  # 检查是否要切换场景

# 监听从草地回到主场景
func _on_go_back_to_home_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.next_scene = "res://Scene/home.tscn"  # 进入家

func _on_go_back_to_home_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

# 监听从草地进入商店
func _on_go_into_shop_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.previous_scene = global.current_scene  # 记录上一个场景
		global.next_scene = "res://Scene/shop.tscn"  # 设置跳转到商店场景

func _on_go_into_shop_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

# 场景切换逻辑
func change_scene():
	if global.transition_scene:
		get_tree().change_scene_to_file(global.next_scene)  # 执行场景跳转
		global.finish_changescenes()  # 完成场景转换
