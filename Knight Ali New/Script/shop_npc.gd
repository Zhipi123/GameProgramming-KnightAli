extends CharacterBody2D

@export var walk_speed: float = 50.0
@export var idle_left_animation: String = "idle_left"
@export var idle_right_animation: String = "idle_right"
@export var walk_left_animation: String = "walk_left"
@export var walk_right_animation: String = "walk_right"

var move_target: Vector2
var is_walking: bool = false
var is_moving_left: bool = false

var min_x: float = 45
var max_x: float = 777
var min_y: float = 300
var max_y: float = 545

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_random_move_target():
	var random_x = randf_range(min_x, max_x) 
	var random_y = randf_range(min_y, max_y) 
	return Vector2(random_x, random_y)

func _ready():
	move_target = get_random_move_target() 

func _process(delta):
	move_npc(delta) 

func move_npc(delta):
	var direction_to_target = (move_target - global_position).normalized()

	velocity = direction_to_target * walk_speed

	move_and_slide()

	play_walk_animation(direction_to_target)

	if global_position.distance_to(move_target) < 10:
		move_target = get_random_move_target()  
	
	
func play_walk_animation(direction_to_target: Vector2):
	if direction_to_target.x < 0:
		animated_sprite.play(walk_left_animation)
		is_moving_left = true
	else:
		animated_sprite.play(walk_right_animation)
		is_moving_left = false

func play_idle_animation():
	if is_moving_left:
		animated_sprite.play(idle_left_animation)
	else:
		animated_sprite.play(idle_right_animation)


func _on_area_entered(area):
	if area is CollisionPolygon2D:
		move_target = global_position - (move_target - global_position) * 2 
