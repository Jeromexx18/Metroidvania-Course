@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateIdle extends PlayerState
 




func init()->void:
	
	pass
	
	
func enter()->void:
	#play animations here
	player.animation_player.play("idle")
	player.collision_crouch.disabled=true
	player.jump_count = 0 
	player.dash_count = 0 
	
	pass

func exit()->void:
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	if _event.is_action_pressed( "dash" ) and player.can_dash():
		print("enter11:", dash.name)
		return dash
	
	if _event.is_action_pressed( "attack" ):
		return attack
	if _event.is_action_pressed( "jump" ):
		return jump
	if _event.is_action_pressed("action") and player.can_morph():
		return ball
	return null
	
	
func process(_delta: float) -> PlayerState:
	if player.direction.x!=0:
		return run
	elif player.direction.y>0.5:
		return crouch
	
	return null
	

func physics_process(_delta: float)->PlayerState:
	player.velocity.x=0
	if player.is_on_floor()==false:
		return fall
	return next_state
