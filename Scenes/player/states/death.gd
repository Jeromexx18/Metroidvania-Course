@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateDeath extends PlayerState
 
const DEATH_AUDIO = preload("uid://drudl3eyrksti")



	
func enter()->void:
	#play animations here
	player.animation_player.play("death")
	Audio.play_spatial_sound(DEATH_AUDIO,player.global_position, true)
	Audio.play_music(null)
	await player.animation_player.animation_finished
	PlayerHud.show_game_over()
	pass

func exit()->void:
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	
	return null
	
	
func process(_delta: float) -> PlayerState:
	
	return null
	

func physics_process(_delta: float)->PlayerState:
	player.velocity.x=0
	player.velocity.y=0
	#player.collision_crouch.disabled=true
	#player.collision_stand.disabled=true
	player.collision_crouch.visible=false
	player.collision_stand.visible=false
	
	player.da_stand.disabled = true
	player.da_crouch.disabled=true
	return null
