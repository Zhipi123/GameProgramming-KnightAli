extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()
	global.current_scene = "ShopScene"  
	print("Current Scene:", global.current_scene)
	print("Previous Scene:", global.previous_scene)  
	print("Next Scene:", global.next_scene)  
	print(global.buy_or_not)
	if global.buy_or_not == true:
		global.buy_or_not = false
		$player.position.x = global.after_buy_posx
		$player.position.y = global.after_buy_posy
	elif global.previous_scene == "GrassScene" or global.previous_scene == "SnowScene":
		$player.position.x = global.player_come_shop_posx
		$player.position.y = global.player_come_shop_posy
	
	
func _process(delta):
	change_scene()

func _on_go_back_to_scene_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		if global.previous_scene == "GrassScene":
			global.next_scene = "res://Scene/grass.tscn"
		elif global.previous_scene == "SnowScene":
			global.next_scene = "res://Scene/snow.tscn"

func _on_go_back_to_scene_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene :
		global.previous_scene = "ShopScene"
		get_tree().change_scene_to_file(global.next_scene)
		global.finish_changescenes() 
		
func go_buy():
		get_tree().change_scene_to_file("res://Scene/buy.tscn")

func _on_buy_area_body_entered(body):
	if body.has_method("player"):
		call_deferred("go_buy")
