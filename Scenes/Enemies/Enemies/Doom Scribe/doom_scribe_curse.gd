class_name DoomScribeCurse extends Node2D

var damage :float =10.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage_player() -> void:
	
	$AttackArea.activate()
	
	pass
