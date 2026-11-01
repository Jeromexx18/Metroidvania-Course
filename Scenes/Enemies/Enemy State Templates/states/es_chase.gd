class_name ESChase

extends EnemyState

@export var chase_speed: float =50
@onready var player_sensor: PlayerSensor = %PlayerSensor

@onready var edge_sensor: EdgeSensor = %EdgeSensor

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	enemy.play_animation( animation_name if animation_name else "attack")
	pass # Replace with function body.
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func exit() -> void:
	pass
	
	
func physics_update(_delta: float) -> void:
	#if not is_instance_valid( blackboard.target):
		#enemy.velocity.x=0
		#return
	var dir: float = sign (blackboard.target.global_position.x - enemy.global_position.x)
	
	enemy.change_dir( dir )
	enemy.velocity.x = dir * chase_speed
	
	pass
