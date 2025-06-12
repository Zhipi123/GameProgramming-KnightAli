extends Node2D

@onready var alert = $Window
@onready var alert2 = $Window2
@onready var alert3 = $Window3
@onready var alert4 = $Window4
var is_30 = false

func _ready():
	$AudioStreamPlayer2D.play()
	alert.hide()
	alert2.hide()
	alert3.hide()
	alert4.hide()
	if global.first_to_grass == true:
		alert4.show()
		global.first_to_grass = false
		get_tree().paused = true
	print(global.weapon_scene)
	global.scene_enemy_count = 0
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
	if global.kill_enemies == 30 and is_30 == false:
		alert3.show()
		get_tree().paused = true
		is_30 = true
		
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
	if body.has_method("player") && global.kill_enemies >= 30:
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/snow.tscn"
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true

func _on_correct_road_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene():
	if global.transition_scene:
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes()

func _on_window_close_requested():
	alert.hide()
	get_tree().paused = false

func _on_window_2_close_requested():
	alert2.hide()
	get_tree().paused = false

func _on_window_3_close_requested():
	alert3.hide()
	get_tree().paused = false

func _on_window_4_close_requested():
	alert4.hide()
	global.first_to_grass = false
	get_tree().paused = false
	
func _on_wrong_road_1_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 30:
		alert.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true
func _on_wrong_road_2_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 30:
		alert.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true
func _on_wrong_road_3_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 30:
		alert.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true
func _on_wrong_road_4_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 30:
		alert.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true
func _on_wrong_road_5_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 30:
		alert.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 30:
		alert2.show()
		get_tree().paused = true

