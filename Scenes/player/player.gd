extends CharacterBody2D

class_name Player

const DEBUG_JUMP_INDICATOR = preload("uid://bubqo8kicvqrj")
#region //

signal damage_taken

#endregion



#region // on ready variables
@onready var sprite: PlayerSprite = %Sprite2D
@onready var attack_sprite_2d: Sprite2D = %AttackSprite2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var oneway_platform_shape_cast: ShapeCast2D = $OnewayPlatformShapeCast
@onready var attack_area: AttackArea = $AttackArea






#endregion

#region /// collisions
@onready var collision_stand: CollisionShape2D = $CollisionStand2D
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch2D

@onready var da_stand: CollisionShape2D = %DAStand
@onready var da_crouch: CollisionShape2D = %DACrouch
@onready var damage_area: DamageArea = %DamageArea
#endregion


#region /// standard variables?
@export var gravity: float=1000
@export var move_speed:float=300
var direction:Vector2=Vector2.ZERO
var flip_h:bool=false
var gravity_multiplier:float=1.0
@export var max_fall_velocity:float=600
var recoil:Vector2 = Vector2.ZERO

#endregion

#region /// Player Stats
var hp:float=10:
	set( value ):
		hp = clampf( value, 0, max_hp)
		Messages.player_health_changed.emit( hp, max_hp)

var max_hp:float=10:
	set( value ):
		max_hp = value
		Messages.player_health_changed.emit( hp,max_hp )
		
		
		
#region // Abilities
var double_jump:bool=false
var jump_count :int= 0
var dash:bool=false
var dash_count:int=0
var ground_slam:bool=false
var morph_roll:bool=false

var can_interact : bool = false

#endregion

#endregion



#region /// state machin3 variables
var states:Array[PlayerState]
#this is a unique name
var current_state:PlayerState:
	get:return states.front()
var previous_state:PlayerState:
	get:return states[1]
			 


#endregion

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player")!=self:
		self.queue_free()
	intialize_states()
	self.call_deferred("reparent", get_tree().root)
	Messages.player_healed.connect( on_player_healed )
	Messages.back_to_title_screen.connect( queue_free)
	Messages.input_hint_changed.connect( _on_input_hint_changed )
	
	damage_area.damage_taken.connect(_on_damage_taken)
	hp=max_hp
	
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
		
	if event.is_action_pressed( "action" ):
		Messages.player_interacted.emit( self )
		
	elif event.is_action_pressed("pause"):
		#buitl in feature below
		get_tree().paused = true
		var pause_menu : PauseMenu = preload( "res://Metroidvania Course/Scenes/pause_menu/pause_menu.tscn" ).instantiate()
		add_child( pause_menu )
		return
		
		
		
		
	#rid of this later
	if OS.is_debug_build():
		if event is InputEventKey and  event.pressed:
			if event.keycode == KEY_MINUS:
				if Input.is_key_pressed( KEY_SHIFT ):
					max_hp -= 10
				
				else :
					hp -= 2
			elif event.keycode == KEY_EQUAL:
				if Input.is_key_pressed( KEY_SHIFT ):
					max_hp += 10
				else:
					hp +=2
	
	change_state(current_state.handle_input(event))
	pass
	
	
	
func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass
	
	
	

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y+=gravity*_delta*gravity_multiplier
		#will increase velocity when falling
	velocity.y=clampf(velocity.y, -1000.0, max_fall_velocity)
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	
	#drop_through_platform()
	#add recoil velocity
	#velocity+=recoil
	#recoil = Vector2.RIGHT
	pass
	#region /// comments nothing here
#func update_animation():
	#
	#if direction>0:
		#Sprite2D.flip_h=true
	#else:
		#Sprite2D.flip_h=false
		#velocity.y=gravity
	#pass
	#endregion ///
	
	
func intialize_states():
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.player=self
			
	if states.size()==0:
		return
		
	#intilialize all states
	for state in states:
		state.init()
	
	change_state(current_state)
	current_state.enter()
	$Label.text=current_state.name
	pass
	
#region /// this is our state switch
	#set our first state
func change_state(new_state:PlayerState)->void:
	if new_state==null:
		return
	elif new_state==current_state:
		return

	if current_state:
		current_state.exit()
	# this is pushing our state to update unlike python we arent calling the update method so we hard code it
	states.push_front(new_state)
	current_state.enter()
	states.resize(4)
	$Label.text=current_state.name
	pass
#endregion ///
	
func update_direction():
	var prev_direction:Vector2=direction
	
	var x_axis=Input.get_axis("left","right")
	var y_axis=Input.get_axis("up","down")
	direction=Vector2(x_axis,y_axis)
	#do more stuff
	if prev_direction.x!=direction.x:
		attack_area.flip(direction.x)
		if direction.x<0:
			#left
			sprite.flip_h=true
			attack_sprite_2d.flip_h = true
			attack_sprite_2d.position.x =-24
			
		elif direction.x>0:
			sprite.flip_h=false
			attack_sprite_2d.flip_h = false
			attack_sprite_2d.position.x =24
	pass
	
	
	
	
func drop_through_platform():
	set_collision_mask_value(2, false)
	await get_tree().create_timer(0.2).timeout
	set_collision_mask_value(2,true)
	pass
	


#func add_debug_indicator(color: Color=Color.RED):
	#var d:Node2D=DEBUG_JUMP_INDICATOR.instantiate()
	#get_tree().root.add_child(d)
	#d.global_position=global_position
	#d.modulate=color
	#await get_tree().create_timer(3.0).timeout
	#d.queue_free()
	#pass
	
	
func _on_input_hint_changed(prompt_name: String) ->void:
	if prompt_name == "interact":
		can_interact = true
	else:
		can_interact = false
	
	pass



func on_player_healed(amount : float)->void:
	hp  +=amount
	print( "player healed for:", amount )
	
	pass
	
	

func _on_damage_taken( a :AttackArea ) ->void:
	if current_state == PlayerStateDeath:
		
		return
	hp -=  a.damage
	damage_taken.emit()
	#print("player took damage!!:" , hp)
	pass


func can_dash() ->bool:
	
	if dash == false or dash_count > 0:
	
		return false
		
	return true

func can_morph() ->bool:
	if morph_roll == false or can_interact== true:
		return false
	return true
