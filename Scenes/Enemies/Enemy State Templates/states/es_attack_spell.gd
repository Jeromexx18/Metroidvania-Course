class_name ESAttackSpell extends ESAttack


# Called when the node enters the scene tree for the first time.
@export var cast_duration : float =1.0
@export_file( "*.tscn" ) var spell_scene : String


func enter() -> void:
	super()
	duration = cast_duration
	
	pass
