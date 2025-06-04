extends Node

var player_current_attack = false

var current_scene = "HomeScene"
var transition_scene = false
var next_scene = ""  # ✅ 新增字段：记录要切换到的场景路径

var player_exit_home_posx = 0 
var player_exit_home_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene.get_file().get_basename()  # 也可以写死为 "HomeScene"、"ShopScene"
