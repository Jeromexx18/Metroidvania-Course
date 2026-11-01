@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateJump extends PlayerState
 

@export var jump_velocity:float=100


const JUMP_AUDIO = preload("uid://cu4climppj65")



func init()->void:
	
	pass
	
	
func enter()->void:
	if player.is_on_floor():
		VisualEffects.jump_dust(player.global_position)
	else:
		VisualEffects.hit_dust(player.global_position)
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	do_jump()
	
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_velocity
	#cheksing if this is a buffer jump
	Audio.play_spatial_sound(JUMP_AUDIO,player.global_position,false, true, 0.25)
	if player.previous_state==fall and not Input.is_action_pressed("jump"):
		#should change state without forcing many frames
		await get_tree().physics_frame
		player.velocity.y *=0.5
		player.change_state(fall)
	
	pass
	
	
	
#what happens wheb we exit
func exit()->void:
	#player.add_debug_indicator(Color.YELLOW)
	pass
	
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	if _event.is_action_pressed( "dash" ) and player.can_dash():
		return dash
	
	if _event.is_action_pressed("attack"):
		if player.ground_slam and Input.is_action_pressed("down"):
			return ground_slam
		return attack
		
	if _event.is_action_released("jump"):
		
		return fall
	if _event.is_action_pressed("action") and player.can_morph():
		return ball
	
	return next_state
	
	
func process(_delta: float) -> PlayerState:
	
	set_jump_frame()
	return next_state
	

func physics_process(_delta: float)->PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y>0:
		return fall
	player.velocity.x=player.direction.x * player.move_speed
	return next_state
	
#func set_jump_frame( frame_count : ) -> void:
	#var frame = remap(
		#player.velocity.y,
		#-jump_velocity,
		#player.max_fall_velocity,
		#0,
		#frame_count - 1
	#)
	#var frame_count = player.animation_player.seek(frame, true) #"jump")
	#
	#
	#frame = clamp(frame, 0, frame_count - 1)
	#player.animated_sprite_2d.frame = int(frame)
	

func do_jump():
	if player.jump_count >0:
		if player.double_jump == false:
			return
		elif player.jump_count > 1:
			return
	player.jump_count += 1
	player.velocity.y = -jump_velocity
	Audio.play_spatial_sound(JUMP_AUDIO,player.global_position,false, true, 0.25)
	pass
	
	
func set_jump_frame()->void:
	##frame remapping
	var frame:float=remap(player.velocity.y, -jump_velocity,0.0,0.0,0.5)
	player.animation_player.seek(frame,true)
	pass
