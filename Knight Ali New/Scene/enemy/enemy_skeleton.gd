extends "res://Script/enemy.gd"  

func _ready():
	self.speed = 120  
	self.idle_speed = 40  
	self.health = 80
	self.random_move_range = 60 
	super._ready() 

func update_health():
	var healthbar = $health_bar
	healthbar.value = health
	if health >= 80:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func die():
	is_dying = true
	$AnimatedSprite2D.play("death")
	print("Enemy died!")
	global.kill_enemies +=1
	global.current_coins +=7
	global.scene_enemy_count -=1
	await get_tree().create_timer(0.6).timeout 
	queue_free()
