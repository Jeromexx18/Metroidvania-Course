class_name ESWalk  extends EnemyState


@export var walk_speed: float = 30


func enter() -> void:
	var anim : String = animation_name if animation_name else "walk"
	enemy.play_animation(anim)
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta: float) ->void:
	if enemy.is_on_wall():
		enemy.change_dir( -blackboard.dir)
	#print("dir =", blackboard.dir)
	enemy.velocity.x = walk_speed * blackboard.dir
	pass
