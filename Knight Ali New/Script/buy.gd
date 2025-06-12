extends Node2D

@onready var failalert = $FailWindow
@onready var successalert = $SuccessWindow
@onready var cur_coins = $Currentcoins/coins

func _ready():
	$AudioStreamPlayer2D.play()
	global.buy_or_not = true
	failalert.hide()
	successalert.hide()
	cur_coins.text = str(global.current_coins) 
	
	
func _process(delta):
	pass

func _on_success_window_close_requested():
	successalert.hide()

func _on_fail_window_close_requested():
	failalert.hide()

func _on_buy_glock_pressed():
	if global.current_coins >= 70:
		global.current_coins -= 70
		global.weapon_scene = preload("res://Scene/weapons/glock_sunrise.tscn")
		
		successalert.show()
	else:
		failalert.show()


func _on_buy_m_4_pressed():
	if global.current_coins >= 200:
		global.current_coins -= 200
		global.weapon_scene = preload("res://Scene/weapons/m4a1.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scene/shop.tscn")  # 请根据你的实际路径调整


func _on_buy_mac_10_pressed():
	if global.current_coins >= 120:
		global.current_coins -= 120
		global.weapon_scene = preload("res://Scene/weapons/mac_10.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_spas_pressed():
	if global.current_coins >= 250:
		global.current_coins -= 250
		global.weapon_scene = preload("res://Scene/weapons/spas_12.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_ak_pressed():
	if global.current_coins >= 260:
		global.current_coins -= 260
		global.weapon_scene = preload("res://Scene/weapons/ak_47.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_awp_pressed():
	if global.current_coins >= 180:
		global.current_coins -= 180
		global.weapon_scene = preload("res://Scene/weapons/awp.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_famas_pressed():
	if global.current_coins >= 160:
		global.current_coins -= 160
		global.weapon_scene = preload("res://Scene/weapons/famas.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_qbz_pressed():
	if global.current_coins >= 260:
		global.current_coins -= 260
		global.weapon_scene = preload("res://Scene/weapons/qbz_95.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_aa_12_pressed():
	if global.current_coins >= 500:
		global.current_coins -= 500
		global.weapon_scene = preload("res://Scene/weapons/aa_12.tscn")
		successalert.show()
	else:
		failalert.show()


func _on_buy_mystery_pressed():
	if global.current_coins >= 1000:
		global.current_coins -= 1000
		global.weapon_scene = preload("res://Scene/weapons/diicsu_gun.tscn")
		successalert.show()
	else:
		failalert.show()
