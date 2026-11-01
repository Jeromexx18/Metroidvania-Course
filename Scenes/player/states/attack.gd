@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerAttack extends PlayerState

#const AUDIO_ATTACK = preload("uid://g2h56xr6x5e0")
const AUDIO_ATTACK = preload("uid://gg38px7mokm4")

@onready var attack_sprite_2d: Sprite2D = %AttackSprite2D

@export var combo_time_window : float =0.2
@export var move_speed : float =100
var timer :float =0
var combo :int =0






#what happens when the state is initiated
func init()->void:
	attack_sprite_2d.visible=false
	pass
	
	
func enter()->void:
	#play animation
	do_attack()
	player.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func exit()->void:
	timer=0
	combo=0
	player.animation_player.animation_finished.disconnect(_on_animation_finished)
	next_state = null
	attack_sprite_2d.visible=false
	pass
	
func process(delta: float) -> PlayerState:
	timer -= delta
	return next_state
	
func physics_process(_delta: float)->PlayerState:
	player.velocity.x = player.direction.x * move_speed
	return null
	#
	

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("attack"):
		timer=combo_time_window
		
	if _event.is_action_pressed( "dash" ) and player.can_dash() :
		return dash
	if _event.is_action_pressed("action") and player.can_morph():
		return ball
	return null

func do_attack() ->void:
	var anim_name :String = "attack"
	if combo > 0:
		anim_name = "attack_2"
	player.animation_player.play(anim_name)
	player.attack_area.activate()
	Audio.play_spatial_sound( AUDIO_ATTACK, player.global_position, false, true, 0.25)
	
	pass



func _end_attack():
	if timer > 0:
		combo = wrapi(combo + 1 ,0,2)
		do_attack()
	else:
		if player.is_on_floor():
			next_state = idle
		else :
			next_state = fall
	pass
	
func _on_animation_finished( _anim_name :String) -> void:
	_end_attack()
	pass
