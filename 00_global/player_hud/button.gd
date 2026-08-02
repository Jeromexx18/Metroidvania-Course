extends Button

@export var particle_settings:HitParticleSettings
@onready var button: Button = %Button



func _ready()->void:
	pressed.connect( _on_pressed )
	pass
	
	
func _on_pressed() -> void:
	#var player :Player = get_tree().get_first_node_in_group( "Player" )
	var pos :Vector2 = get_tree().get_first_node_in_group( "Player" ).global_position
	VisualEffects.hit_particles( pos, Vector2(-1,-1),particle_settings )
	#player.dash = !player.dash
	button.grab_focus()
	
	pass
