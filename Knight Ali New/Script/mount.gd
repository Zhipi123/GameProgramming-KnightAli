extends Node2D

@onready var alert1 = $Window1
@onready var alert2 = $Window2

func _ready():
	$AudioStreamPlayer2D.play()
	global.scene_enemy_count = 1
	if global.first_to_mount == true:
		alert1.show()
		get_tree().paused = true
	global.scene_enemy_count = 0
	global.current_scene = "MountScene"
	print(global.current_scene)
	print(global.previous_scene)
	print(global.next_scene)

	if global.previous_scene == "SnowScene":
		$player.position.x = global.snow_to_mount_posx
		$player.position.y = global.snow_to_mount_posy
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.is_boss_dead == true:
		alert2.show()
		get_tree().paused = true
		await get_tree().create_timer(2.0).timeout
		get_tree().paused = false
		call_deferred("game_over")
		

func _on_window_1_close_requested():
	alert1.hide()
	get_tree().paused = false


func _on_window_2_close_requested():
	alert2.hide()
	get_tree().paused = false

func game_over():
	get_tree().change_scene_to_file("res://Scene/GUI/game_over.tscn")
