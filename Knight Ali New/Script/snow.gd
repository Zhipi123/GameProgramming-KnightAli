extends Node2D

@onready var alert1 = $Window1
@onready var alert2 = $Window2
@onready var alert3 = $Window3
@onready var alert4 = $Window_welcome
var is_60 = false

func _ready():
	$AudioStreamPlayer2D.play()
	alert1.hide()
	alert2.hide()
	alert3.hide()
	if global.first_to_snow == true:
		alert4.show()
		get_tree().paused = true
		global.first_to_snow = false
	global.scene_enemy_count = 0
	global.current_scene = "SnowScene"
	print(global.current_scene)
	print(global.previous_scene)
	print(global.next_scene)

	if global.previous_scene == "GrassScene":
		$player.position.x = global.grass_to_snow_posx
		$player.position.y = global.grass_to_snow_posy
	elif global.previous_scene == "ShopScene":
		$player.position.x = global.grass_to_snowshop_posx
		$player.position.y = global.grass_to_snowshop_posy
	
		
func _process(delta):
	if global.kill_enemies == 60 and is_60 == false:
		alert3.show()
		get_tree().paused = true
		is_60 = true
	change_scene()

func _on_go_into_shop_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/shop.tscn"

func _on_go_into_shop_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_go_back_to_grass_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/grass.tscn"

func _on_go_back_to_grass_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene:
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes()


func _on_go_to_mountboss_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 60:
		global.transition_scene = true
		global.previous_scene = global.current_scene
		global.next_scene = "res://Scene/mount.tscn"
	elif body.has_method("player") && global.kill_enemies < 60:
		alert2.show()
		get_tree().paused = true
		

func _on_go_to_mountboss_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false


func _on_window_1_close_requested():
	alert1.hide()
	get_tree().paused = false


func _on_window_2_close_requested():
	alert2.hide()
	get_tree().paused = false


func _on_window_3_close_requested():
	alert3.hide()
	get_tree().paused = false


func _on_wrongroad_1_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 60:
		alert1.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 60:
		alert2.show()
		get_tree().paused = true
		
func _on_wrongroad_2_body_entered(body):
	if body.has_method("player") && global.kill_enemies >= 60:
		alert1.show()
		get_tree().paused = true
	elif body.has_method("player") && global.kill_enemies < 60:
		alert2.show()
		get_tree().paused = true


func _on_window_welcome_close_requested():
	alert4.hide()
	get_tree().paused = false
