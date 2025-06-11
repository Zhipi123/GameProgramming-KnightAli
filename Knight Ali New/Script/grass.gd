extends Node2D

@onready var alert = $Window

func _ready():
	print(global.weapon_scene)
	global.scene_enemy_count = 0
	alert.hide()
	global.current_scene = "GrassScene"
	print(global.current_scene)
	print(global.previous_scene)
	print(global.next_scene)

	if global.previous_scene == "HomeScene":
		$player.position.x = global.grass_to_home_posx
		$player.position.y = global.grass_to_home_posy
	elif global.previous_scene == "ShopScene":
		$player.position.x = global.grass_to_shop_posx
		$player.position.y = global.grass_to_shop_posy
	elif global.previous_scene == "SnowScene":
		$player.position.x = global.snow_to_grass_posx
		$player.position.y = global.snow_to_grass_posy

func _process(delta):
	change_scene()

func _on_go_back_to_home_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.next_scene = "res://Scene/home.tscn"

func _on_go_back_to_home_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_go_into_shop_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/shop.tscn"

func _on_go_into_shop_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
	
func _on_correct_road_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/snow.tscn"

func _on_correct_road_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene():
	if global.transition_scene:
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes()

func _on_window_close_requested():
	alert.hide()

func _on_wrong_road_1_body_entered(body):
	if body.has_method("player"):
		alert.show()
func _on_wrong_road_2_body_entered(body):
	if body.has_method("player"):
		alert.show()
func _on_wrong_road_3_body_entered(body):
	if body.has_method("player"):
		alert.show()
func _on_wrong_road_4_body_entered(body):
	if body.has_method("player"):
		alert.show()
func _on_wrong_road_5_body_entered(body):
	if body.has_method("player"):
		alert.show()

