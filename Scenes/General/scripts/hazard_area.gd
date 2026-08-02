@icon("res://Platformer/icons/hazard_area.svg")
class_name HazardArea
extends AttackArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	visible = true
	monitoring=true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
