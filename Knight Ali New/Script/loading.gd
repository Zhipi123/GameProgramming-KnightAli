extends Control

var load_over: bool
var start_scene

func _enter_tree():
	start_scene = load("res://Scene/home.tscn")
	load_over = false
	await get_tree().create_timer(2).timeout
	load_over = true

func _process(delta):
	if load_over:
		get_tree().change_scene_to_packed(start_scene)
