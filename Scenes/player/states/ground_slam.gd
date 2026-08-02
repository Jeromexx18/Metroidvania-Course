@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")
class_name PlayerStateGroundSlam extends PlayerState
 
@export var velocity:float=400
@export var effect_delay: float =0.075
var effect_timer:float=0

const BOOM_AUDIO = preload("uid://dxkevv7nxe3p7")
const SLAM_AUDIO = preload("uid://btat8ekvgwlw2")
const BREAK_WOOD_AUDIO = preload("uid://cmlycjl4bmcdx")

#region / particles

#const HIT_WOOD_LARGE = preload("uid://b7ufq3mwxv2r3")
#const HIT_WOOD_MEDIUM = preload("uid://cmij0lcukh7gn")
#const HIT_WOOD_SMALL = preload("uid://dny0jusem76gw")
const HIT_WOOD_LARGE = preload("uid://b7ufq3mwxv2r3")
const HIT_WOOD_MEDIUM = preload("uid://cmij0lcukh7gn")
const HIT_WOOD_SMALL = preload("uid://dny0jusem76gw")


#endregion




@onready var damage_area: DamageArea = %DamageArea
#@onready var ground_shape_cast: ShapeCast2D = %GroundShapeCast

@onready var ground_slam_attack_area: AttackArea = %GroundSlamAttackArea
@onready var ground_slam_shape_cast: ShapeCast2D = %GroundSlamShapeCast


func init()->void:
	
	pass
	
	
func enter()->void:
	#play animations here
	player.animation_player.play("ground_slam")
	player.sprite.tween_color()
	Audio.play_spatial_sound(SLAM_AUDIO, player.global_position, false, true, 0.75)
	Audio.play_spatial_sound(BOOM_AUDIO, player.global_position)
	damage_area.start_invulnerable()
	ground_slam_attack_area.set_active(true)
	pass

func exit()->void:
	VisualEffects.camera_shake(10.0)
	VisualEffects.land_dust( player.global_position )
	VisualEffects.hit_dust( player.global_position )
	damage_area.end_invulnerable()
	ground_slam_attack_area.set_active(false)
	Audio.play_spatial_sound(BOOM_AUDIO, player.global_position, false, true, 0.75 )
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	#handle other inputs
	
	return null
	
	
func process(_delta: float) -> PlayerState:
	check_collisions(_delta)
	#collision checking
	effect_timer=-_delta
	if effect_timer < 0:
		effect_timer = effect_delay
		player.sprite.ghost()
	return null
	

func physics_process(_delta: float)->PlayerState:
	player.velocity = Vector2(0, velocity)
	if player.is_on_floor():
		if not check_collisions(_delta):
	
			return idle
	return next_state


func check_collisions(_delta :float ) ->bool:
	#the 3 is the movement in pixels
	ground_slam_shape_cast.target_position.y = velocity * _delta
	ground_slam_shape_cast.force_shapecast_update()
	if ground_slam_shape_cast.is_colliding():
		for i in ground_slam_shape_cast.get_collision_count():
			var c = ground_slam_shape_cast.get_collider(i)
			var pos : Vector2 = ground_slam_shape_cast.get_collision_point(i)
			#heandle regular breakables
			if c.get_parent() is Breakable:
				var b : Breakable =c.get_parent()
				b.queue_free()
				Audio.play_spatial_sound(b.destroy_audio, pos, false, true, 0.75)
				for p in b.destroy_particles:
					VisualEffects.hit_particles(pos, Vector2.DOWN, HIT_WOOD_LARGE)
					VisualEffects.hit_particles(pos, Vector2.DOWN, HIT_WOOD_MEDIUM)
			else: 
			
				c.queue_free()
				VisualEffects.hit_particles(pos, Vector2.DOWN, HIT_WOOD_LARGE)
				VisualEffects.hit_particles(pos, Vector2.DOWN, HIT_WOOD_MEDIUM)
				VisualEffects.hit_particles(pos, Vector2.UP, HIT_WOOD_SMALL)
				Audio.play_spatial_sound(BREAK_WOOD_AUDIO, pos)
			VisualEffects.hit_dust( pos )
			VisualEffects.camera_shake(10.0)
		return true
	
	return false
