extends CanvasLayer

@onready var coin_label = $HBoxContainer/Label  # 获取显示金币数的 Label
@onready var enemy_count_label = $HBoxContainer2/Label/enemy_count
@onready var scene_enemy_count = $HBoxContainer3/Label/Label

func _ready():
	# 初始化时更新显示的金币数和敌人击杀数
	update_coin_display()
	update_enemy_count()
	update_scene_enemy_count()

func _process(delta):
	# 每帧更新显示的金币数和敌人击杀数
	update_coin_display()
	update_enemy_count()
	update_scene_enemy_count()

# 更新金币显示
func update_coin_display():
	coin_label.text =  str(global.current_coins)  # 显示当前金币数量

# 更新击杀敌人数量显示
func update_enemy_count():
	enemy_count_label.text =  str(global.kill_enemies)  # 显示当前击杀的敌人数量
	
func update_scene_enemy_count():
	scene_enemy_count.text =  str(global.scene_enemy_count)  # 显示当前场景的敌人数量
