extends "res://Script/bullet1.gd"

func _ready():
	super._ready()
	self.speed = 300 
	self.damage = 15  

func _on_body_entered(body):
	pass
		
func _on_player_body_entered(body):
	if body.has_method("player"):
		body.on_bullet(damage)
		queue_free()
