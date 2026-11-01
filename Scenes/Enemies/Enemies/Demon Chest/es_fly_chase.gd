class_name ESFlychase

extends EnemyState

@export var chase_speed: float =100
@onready var player_sensor: PlayerSensor = %PlayerSensor

@onready var edge_sensor: EdgeSensor = %EdgeSensor

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	
	var anim: String = animation_name if animation_name else "chase"
	enemy.play_animation(anim)
	pass # Replace with function body.
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func exit() -> void:
	pass
	
	
func physics_update(_delta: float) -> void:
	var dir:Vector2 = enemy.global_position.direction_to ( blackboard.target.global_position)
	enemy.change_dir( sign( dir.x) )
	enemy.velocity = chase_speed * dir 
		
	pass
