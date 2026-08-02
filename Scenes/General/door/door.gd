@tool
@icon("res://Platformer/Scenes/General/door/door.svg")
class_name Door extends Node2D

const DOOR_CRASH_AUDIO = preload("uid://5efajx6um3ve")
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	if Engine.is_editor_hint():
		
		return
	for c in get_children():
		if c is Switch:
			c.activated.connect( _on_switch_is_activated )
			if c.is_open == true:
				_on_switch_is_open()
		
		#connect to switch code
	pass
	
func _on_switch_is_activated() ->void:
	#audio playback
	Audio.play_spatial_sound( DOOR_CRASH_AUDIO, global_position )
	animation_player.play( "open" )
	
	
func _on_switch_is_open() ->void:
	#audio playback
	animation_player.play( "opened" )
	
	pass
	
	
func _get_configuration_warnings() -> PackedStringArray:
	
	if _check_for_switch() == false:
		return[ "Requires a Switch Node" ]
	return[]
	
	
func _check_for_switch() ->bool:
	for c in get_children():
		if c is Switch:
			return true
	
	
	return false
