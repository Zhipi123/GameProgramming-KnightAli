extends Node2D

@onready var alert = $Window

func _ready():
	$AudioStreamPlayer2D.play()
	if global.first_to_home == true:
		global.first_to_home = false
		alert.show()
		get_tree().paused = true
	global.scene_enemy_count = 0
	global.current_coins = 100
	global.kill_enemies = 0
	global.current_scene = "HomeScene" 
	
	if global.player_at_home_first == true:
		$player.position.x = global.player_home_start_posx
		$player.position.y = global.player_home_start_posy
	elif  global.player_at_home_first == false:
		$player.position.x = global.player_back_home_posx
		$player.position.y = global.player_back_home_posy
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	
func _on_go_out_to_grass_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true 
	
func _on_go_out_to_grass_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "HomeScene":
			global.previous_scene = "HomeScene"
			get_tree().change_scene_to_file("res://Scene/grass.tscn")
			global.player_at_home_first = false
			global.finish_changescenes()


func _on_window_close_requested():
	alert.hide()
	get_tree().paused = false
