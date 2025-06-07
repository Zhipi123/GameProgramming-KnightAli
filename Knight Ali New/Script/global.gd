extends Node

var player_current_attack = false
var previous_scene: String = ""
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
#shop x,y

var player_come_shop_posx = 937
var player_come_shop_posy = 586

var player_health = 100

func finish_changescenes():
	if transition_scene:
		transition_scene = false
		current_scene = next_scene.get_file().get_basename()  
