class_name DecisionEngine extends Node


var enemy : Enemy
var current_state: EnemyState
var blackboard :Blackboard

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while not enemy:
		await get_tree().process_frame
	enemy.change_dir(-1.0 if enemy.face_left_on_start else 1.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func decide() ->EnemyState:
	
	#Example decisions
	
	return null
