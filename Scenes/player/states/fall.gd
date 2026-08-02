@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multiplier:float =1.650
@export var coyote_time:float=0.125
@export var Jump_buffer_timer:float=0.2 #or coyote timer
#jump buffer time




@export var coyote_timer:float=0
@export var buffer_timer:float=0
const LAND_AUDIO = preload("uid://cxmdtk2iyt5op")


#Specifically this is for just avoiding numbers in the functions
var gravity_variable:float=1.0 



func init()->void:
	
	pass
	
	
func enter()->void:
	#play animations here
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.gravity_multiplier=fall_gravity_multiplier
	
	#handle jump count
	if player.jump_count ==0:
		player.jump_count=1
		
	var prev :PlayerState = player.previous_state
	if player.previous_state==jump or prev ==dash:
		coyote_timer=0
	elif player.previous_state == crouch:
		coyote_time=0
		player.jump_count = 1
	else:
		coyote_timer=coyote_time
	pass



func exit()->void:
	
	player.gravity_multiplier=gravity_variable
	buffer_timer=0
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	if _event.is_action_pressed( "dash" ) and player.can_dash():
		return dash
	
	
	if _event.is_action_pressed("attack"):
		if player.ground_slam and Input.is_action_pressed("down"):
			return ground_slam
		return attack
	if _event.is_action_pressed("jump"):
		if coyote_timer>0:
			player.jump_count = 0
		elif player.jump_count <=1 and player.double_jump:
			return jump
		else:
			buffer_timer=Jump_buffer_timer
	if _event.is_action_pressed("action")and player.can_morph():
		return ball
	return next_state
	
	
func process(_delta: float) -> PlayerState:
	
	coyote_timer-=_delta
	buffer_timer-=_delta
	set_jump_frame()
	return next_state
	

func physics_process(_delta: float)->PlayerState:
	if player.is_on_floor():
		#player.add_debug_indicator(Color.RED )
		VisualEffects.land_dust(player.global_position)
		Audio.play_spatial_sound(LAND_AUDIO,player.global_position,false, true, 0.5)
		if buffer_timer>0:
			player.jump_count = 0
		#if buffer_timer>0 and Input.is_action_pressed("jump"):
			return jump
		return idle
	player.velocity.x=player.direction.x * player.move_speed
	return next_state
	
#this is setting the fall animation per frame by using remap
func set_jump_frame()->void:
	#frame remapping
	var frame:float=remap(player.velocity.y,0.0,player.max_fall_velocity,0.5,1.0)
	player.animation_player.seek(frame, true)
	pass
	
	
	
