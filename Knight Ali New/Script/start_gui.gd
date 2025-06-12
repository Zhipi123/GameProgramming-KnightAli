extends Control

func _ready():
	$AudioStreamPlayer2D.play()

func _on_exit_game_button_pressed():
	get_tree().quit()

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scene/GUI/loading.tscn")
