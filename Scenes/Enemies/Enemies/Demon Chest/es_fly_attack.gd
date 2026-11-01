class_name ESFlyAttack
extends EnemyState


@export var attack_range: float = 100
@export var move_speed:float =200
@export var cooldown: float =3.0
@export var attack_area:AttackArea
@export var speed_curve : Curve

var speed_sample:float = 1.0
var dir :Vector2
var timer :float=0
var duration:float =0
var on_cooldown:bool=false

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	enemy.play_animation( animation_name if animation_name else "fly_attack")
	duration = enemy.animation.current_animation_length
	timer = 0
	blackboard.can_decide = false
	on_cooldown=true
	#enemy.velocity.x= move_speed *blackboard.dir
	if attack_area:
		attack_area.flip ( blackboard.dir )
	pass # Replace with function body.

func exit() -> void:
	blackboard.can_decide = true
	#cooldown
	run_cooldown()
	pass

func _re_ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta: float) -> void:
	
	timer += _delta
	if timer >= duration:
		blackboard.can_decide = true
	if speed_curve:
		speed_sample = speed_curve.sample( timer / duration )
	dir = enemy.global_position.direction_to( blackboard.target.global_position )
	enemy.change_dir( sign(dir.x) )
	enemy.velocity = dir * move_speed * speed_sample
	pass
	
func can_attack() ->bool:
	if blackboard.distance_to_target <= attack_range and not on_cooldown:
		return true
	return false

func run_cooldown() ->void:
	await get_tree().create_timer( cooldown ).timeout
	on_cooldown = false
	pass
	
