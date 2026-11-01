class_name DamageModulate  extends Node

var flash_color:Color = Color(4.416, 0.153, 0.071, 1.0)
var tween:Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if owner is Enemy:
		owner.was_hit.connect( _modulate_node )
	else:
		for c in owner.get_children():
			if c is DamageArea:
				c.damage_taken.connect(_modulate_node)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _modulate_node(_a:AttackArea, color:Color=Color(4.415, 0.153, 0.071, 1.0)) -> void:
	if tween:
		tween.kill()
	owner.modulate = color
	tween =create_tween()
	tween.tween_property(owner, "modulate", Color.WHITE,0.5)
	print("modulate")
	pass
