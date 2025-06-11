extends Button

var popup: Popup

func _ready():
	# 初始化popup
	popup = Popup.new()  
	add_child(popup)  # 将popup添加到父节点
	popup.add_child(Label.new())  # 添加Label节点
	popup.get_child(0).text = "This is a popup!"
	popup.hide()  # 默认隐藏弹窗

func _on_pressed():
	# 显示弹窗
	popup.show()
	# 2秒后自动隐藏弹窗
	await get_tree().create_timer(2).timeout  # 等待2秒
	popup.hide()  # 隐藏弹窗
