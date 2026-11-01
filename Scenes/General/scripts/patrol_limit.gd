@tool
@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_05_enemies/ch_05_enemies/icons/patrol_limit.svg")
class_name PatrolLimit
extends Node2D

const PATROL_LIMIT = preload("uid://b3n3hds635sdi")
@export var side : Side = SIDE_LEFT:
	set(value):
		side=value
		_add_sprite()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		#display sprite
		_add_sprite()
		return
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _add_sprite() -> void:
	if get_child_count()>0:
		for c in get_children():
			c.queue_free()
			
	var s: Sprite2D = Sprite2D.new()
	add_child(s)
	s.texture = PATROL_LIMIT
	s.position=Vector2(0, -16)
	
	var l : Label = Label.new()
	add_child( l )
	l.size.x=32
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.position = Vector2(-16,-24)
	
	
	if side == Side.SIDE_LEFT:
		s.modulate = Color.WHITE
	
		l.modulate = Color(0.2,0.2,0.2)
		l.text="L"
	else:
		s.modulate = Color.INDIAN_RED
		l.modulate=Color.WHITE
		l.text="R"
	pass
