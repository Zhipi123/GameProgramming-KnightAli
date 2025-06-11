extends Node

var player_current_attack = false
var previous_scene: String = ""
var scene_change_times = 0
var current_scene = "HomeScene"
var transition_scene = false
var next_scene = ""  
#home x,y
var player_back_home_posx = 750
var player_back_home_posy = 500

var player_home_start_posx = 510
var player_home_start_posy = 382

var player_at_home_first = true
#grass x,y
var grass_to_home_posx = 282
var grass_to_home_posy = 236

var grass_to_shop_posx = 697
var grass_to_shop_posy = 304

var grass_to_snow_posx = 32
var grass_to_snow_posy = 488
#shop x,y
var player_come_shop_posx = 937
var player_come_shop_posy = 586
#snow x,y
var snow_to_grass_posx = 1107
var snow_to_grass_posy = 591

var grass_to_snowshop_posx = 215
var grass_to_snowshop_posy = 245

var after_buy_posx = 507
var after_buy_posy = 324

var player_health = 100

var current_coins = 10
var kill_enemies = 0
var buy_or_not = false
var scene_enemy_count = 0

var weapon_scene: PackedScene = preload("res://Scene/weapons/glock.tscn")
var current_weapon_scene: PackedScene = weapon_scene

func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene.get_file().get_basename()  
