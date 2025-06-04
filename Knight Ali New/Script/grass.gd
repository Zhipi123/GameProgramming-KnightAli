extends Node2D

func _ready():
	global.current_scene = "GrassScene"
	print(global.current_scene)

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
		global.next_scene = "res://Scene/shop.tscn"

func _on_go_into_shop_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene:
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes()
