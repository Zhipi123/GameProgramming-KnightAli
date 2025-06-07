extends Node2D

func _ready():
	global.current_scene = "ShopScene"  
	print("Current Scene:", global.current_scene)
	print("Previous Scene:", global.previous_scene)  
	print("Next Scene:", global.next_scene)  

	if global.previous_scene == "GrassScene":
		$player.position.x = global.player_come_shop_posx
		$player.position.y = global.player_come_shop_posy

func _process(delta):
	change_scene()

func _on_go_back_to_scene_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		if global.previous_scene == "GrassScene":
			global.next_scene = "res://Scene/Grass.tscn"

func _on_go_back_to_scene_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene:
		global.previous_scene = "ShopScene"
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes() 
