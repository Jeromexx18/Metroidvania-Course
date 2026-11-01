@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_01_player_foundations/ch_01_player_foundations/state.svg")

class_name EnemyStateMachine  extends Node

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var enemy : Enemy
var blackboard : Blackboard
var states : Array[ EnemyState ]
var current_state: EnemyState:
	get():
		return states.front()
var  prev_state:EnemyState:
	get():
		return states.get( 1 )
		
func setup( e : Enemy , b : Blackboard ) ->void:
	blackboard = b
	enemy = e
	for c in get_children():
		if c is EnemyState:
			c.enemy = e
			c.blackboard = b
			c.state_machine = self
			states.append( c )
			
		if states.is_empty():
			push_error("EnemyStateMachine has no states!")
			return
	#states[0].enter()
	current_state.enter()
	pass


func change_state(new_state:EnemyState) ->void:
	if not new_state:
		return
		
	if new_state == current_state:
		current_state.re_enter()
		return
	
	if current_state:
		current_state.exit()
		
	states.push_front( new_state )
	current_state.enter()
	if enemy:
		enemy.decision_engine.current_state = new_state
	states.resize( 2 )
	pass

func physics_update(_delta: float) -> void:
	if current_state:
		current_state.physics_update( _delta )
	pass

func play_animation(anim_name:String)->void:
	animation_player.play( "death")
	if animation_player.has_animation( anim_name ):
		animation_player.play( anim_name )
	else:
		printerr( "Animation Missing:", anim_name )
