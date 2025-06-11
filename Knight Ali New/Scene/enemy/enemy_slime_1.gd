extends "res://Script/enemy.gd" 

func _ready():
	self.speed = 80
	self.idle_speed = 40  
	self.health = 100
	self.random_move_range = 40
	super._ready() 

func die():
	is_dying = true
	$AnimatedSprite2D.play("death")
	print("Enemy died!")
	global.kill_enemies +=1
	global.current_coins +=3
	global.scene_enemy_count -=1
	await get_tree().create_timer(0.6).timeout 
	queue_free()
