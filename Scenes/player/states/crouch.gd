@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateCrouch extends PlayerState
 
@export var deceleration_rate:float=10
var can_stand_up:bool=false
var is_dropping:bool=false



func init()->void:
	
	pass
	
	
func enter()->void:
	
	#play animations here
	player.collision_stand.disabled=true
	player.collision_crouch.disabled=false
	player.animation_player.play("crouch")
	player.da_stand.disabled=true
	player.da_crouch.disabled=false
	
	
	can_stand_up=true
	
	pass

func exit()->void:
	can_stand_up=false
	player.collision_stand.set_deferred("disabled",false)
	player.collision_crouch.set_deferred("disabled",true)
	
	player.da_stand.set_deferred("disabled",false)
	player.da_crouch.set_deferred("disabled",true)
	
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	if _event.is_action( "dash" ) and player.can_dash():
		return dash
	
	if _event.is_action_pressed("attack"):
		return attack
	
	if _event.is_action_pressed("jump"):
		#player.one_way_platform_shape_cast.force_shapecast_update()
		if player.oneway_platform_shape_cast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
		
	if _event.is_action_pressed("action") and player.can_morph():
		return ball
	return next_state
	
	
func process(_delta: float) -> PlayerState:
	if player.direction.y<=0.5:
		if can_stand_up:
			return idle
		
	return next_state
	

func physics_process(delta: float)->PlayerState:
	player.velocity.x-= player.velocity.x * deceleration_rate*delta
	if player.is_on_floor()==false:
		return fall
	if player.oneway_platform_shape_cast.is_colliding() == true:
		player.position.y +=4
		player.drop_through_platform()
		return fall
	
	return next_state
