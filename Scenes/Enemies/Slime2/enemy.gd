@tool
@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_05_enemies/ch_05_enemies/icons/enemy.svg")
class_name Enemy extends CharacterBody2D


signal direction_changed( new_dir )
signal was_hit(a: AttackArea)
signal was_killed()

@export var health :float =3
@export var affected_by_gravity : bool = true
@export var face_left_on_start : bool = false: 
	set( value ):
		face_left_on_start = value
		_update_face_left()
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var player_sensor: PlayerSensor = %PlayerSensor


var sprite : Sprite2D
var animation:AnimationPlayer
var damage_area :DamageArea
var hazard_area :HazardArea

var state_machine :EnemyStateMachine 
var decision_engine :DecisionEngine
var black_board:Blackboard

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process( false )
		return
		
	setup()
	pass
	
	
func setup():
	black_board = Blackboard.new()
	black_board.health = health
	for c in get_children():
		if c is AnimationPlayer and not animation:
			animation = c
		elif c is Sprite2D and not sprite:
			sprite = c
		elif c is DamageArea and not damage_area:
			damage_area=c
			c.damage_taken.connect( _on_damage_taken )
		elif c is HazardArea and not hazard_area:
			hazard_area = c
		
		elif c is EnemyStateMachine and not state_machine:
			state_machine=c
		elif c is DecisionEngine and not decision_engine:
			decision_engine=c
			
		pass
	
	
	if state_machine and decision_engine:
		state_machine.setup( self, black_board)
		decision_engine.enemy = self
		decision_engine.blackboard = black_board
	else:
		set_physics_process(false)
	pass
	
	
func _physics_process(delta: float) -> void:
	black_board.update_distance_to_target( global_position )
	state_machine.change_state( decision_engine.decide() )
	if affected_by_gravity:
		velocity = get_gravity() * delta
	state_machine.physics_update(delta)
	move_and_slide()
	pass
	
	
func change_dir( new_dir:float ) ->void:
	black_board.dir= new_dir
	direction_changed.emit( new_dir )
	if sprite:
		if new_dir < 0:
			sprite.flip_h = true
		#elif new_dir > 0:
		else:
			sprite.flip_h = false
	pass
	
func play_animation(anim_name:String)->void:
	
	if animation.has_animation( anim_name ):
		animation.play( anim_name )
	else:
		printerr( "Animation Missing:", anim_name )
		
	pass
	
func _on_damage_taken( a: AttackArea ) ->void:
	black_board.damage_source = a
	black_board.health -= a.damage
	if black_board.health <=0:
		damage_area.queue_free()
		hazard_area.queue_free()
		player_sensor.queue_free()
		collision_shape_2d.queue_free()
		was_killed.emit()
	was_hit.emit( a )
	pass
	
func _get_configuration_warnings() -> PackedStringArray:
	
	var warnings :PackedStringArray =[]
	if not find_children("*", "AnimationPlayer", false):
		warnings.append("Requires an AnimationPlayer!")
	if not find_children("*", "Sprite2D", false):
		warnings.append("Requires a Sprite2D!")
	if not find_children("*", "DamageArea node", false):
		warnings.append("Requires a DamageArea!")
	if not find_children("*", "HazardArea Node", false):
		warnings.append("Requires an HazardArea!")
	if not find_children("*", "EnemyStateMachine", false):
		warnings.append("Requires an EnemyStateMachine!")
	if not find_children("*", "DecisionEngine", false):
		warnings.append("Requires a DecisionEngine node!")
		
	return warnings
	
	

func decide() ->void:
	
	return
func _update_face_left() ->void:
	if not Engine.is_editor_hint():
		return
	for c in get_children():
		if c is Sprite2D:
			c.flip_h = face_left_on_start
	
	pass
