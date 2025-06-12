extends Control

func _ready():
	$AudioStreamPlayer2D.play()
	global.weapon_scene = preload("res://Scene/weapons/glock.tscn")
	global.first_to_home = true
	global.first_to_mount = true
	global.first_to_snow = true
	var first_to_grass = true
	global.player_health = 100
	global.kill_enemies = 0

func go_back_menu():
	get_tree().change_scene_to_file("res://Scene/GUI/start.tscn")

func _on_button_pressed():
	go_back_menu()
