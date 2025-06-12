extends CanvasLayer

@onready var coin_label = $HBoxContainer/Label  
@onready var enemy_count_label = $HBoxContainer2/Label/enemy_count
@onready var scene_enemy_count = $HBoxContainer3/Label/Label
@onready var alert = $Window

func _ready():
	alert.hide()
	update_coin_display()
	update_enemy_count()
	update_scene_enemy_count()

func _process(delta):
	update_coin_display()
	update_enemy_count()
	update_scene_enemy_count()

# 更新金币显示
func update_coin_display():
	coin_label.text =  str(global.current_coins) 

# 更新击杀敌人数量显示
func update_enemy_count():
	enemy_count_label.text =  str(global.kill_enemies) 
	
func update_scene_enemy_count():
	scene_enemy_count.text =  str(global.scene_enemy_count) 

func go_back_menu():
	global.first_to_home = true
	global.first_to_mount = true
	global.first_to_snow = true
	var first_to_grass = true
	global.player_health = 100
	global.kill_enemies = 0
	global.current_coins = 0
	global.weapon_scene = preload("res://Scene/weapons/glock.tscn")
	get_tree().change_scene_to_file("res://Scene/GUI/start.tscn")

func _on_button_pressed():
	alert.show()
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = false
	call_deferred("go_back_menu")
