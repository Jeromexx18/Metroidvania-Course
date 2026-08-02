class_name ESDeath  extends EnemyState




var vel_x :float =0
var duration : float =0 
var timer : float = 0
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

# Called when the node enters the scene tree for the first time.
@export var death_audio:AudioStream
@export var knockback_strength :float =100

# Called when the node enters the scene tree for the first time.
func enter()->void:
	#var anim : String = animation_name if animation_name else "death"
	#enemy.play_animation( animation_name if animation_name else "death")
	#Audio.play_spatial_sound(death_audio, enemy.global_position)
		#
	#duration = enemy.animation.current_animation_length
	#timer=0
	#
	#_calc_velocity( blackboard.damage_source )
	##blackboard.damage_source = null
	##blackboard.can_decide = false
	#
	#await enemy.animation.animation_finished
	#print(state_machine.name, "entered")
	#enemy.queue_free()
	#await get_tree().create_timer( duration ).timeout
	#enemy.animation.animation.queue_free()
	
	print("DEATH ENTER")
	print(animation_player.name,"|")
	await enemy.animation.play("Death")
	blackboard.can_decide = false

	enemy.velocity = Vector2.ZERO

	enemy.play_animation(animation_name if animation_name else "death")

	await enemy.animation.animation_finished

	print("DEATH ANIMATION COMPLETE")

	enemy.queue_free()

	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	timer += delta
	enemy.velocity.x = vel_x * ( 1-timer/duration )
	if timer >= duration:
		blackboard.can_decide = true
	return


func _calc_velocity( a: AttackArea ):
	vel_x = 1
	if a.global_position.x > enemy.global_position.x:
		vel_x = -1
	vel_x *= knockback_strength
	pass
