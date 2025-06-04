extends Node2D

func _ready():
	global.current_scene = "HomeScene" 
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
			get_tree().change_scene_to_file("res://Scene/Grass.tscn")
			global.finish_changescenes()
