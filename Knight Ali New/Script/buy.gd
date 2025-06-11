extends Node2D

@onready var failalert = $FailWindow
@onready var successalert = $SuccessWindow
@onready var cur_coins = $Currentcoins/coins
# Called when the node enters the scene tree for the first time.
func _ready():
	failalert.hide()
	successalert.hide()
	cur_coins.text = str(global.current_coins)  # 更新金币显示
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_success_window_close_requested():
	successalert.hide()

func _on_fail_window_close_requested():
	failalert.hide()

func _on_buy_glock_pressed():
	if global.current_coins >= 100:
		global.current_coins -= 100
		global.weapon_scene = preload("res://Scene/weapons/m4a1.tscn")
		
		successalert.show()
	else:
		failalert.show()


func _on_buy_m_4_pressed():
	if global.current_coins >= 10:
		global.current_coins -= 10
		global.weapon_scene = preload("res://Scene/weapons/m4a1.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scene/shop.tscn")  # 请根据你的实际路径调整
