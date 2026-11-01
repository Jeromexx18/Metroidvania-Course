class_name DecisionEngineBasicAttack
extends DecisionEngine



@export var attack_state: ESAttack
@export var chase_state : EnemyState
#@export var es_walk: EnemyState




#@export var es_death: ESDeath
#@export var es_stun: ESStun


@onready var es_walk: ESWalk = %ESWalk
@onready var es_stun: ESStun = %ESStun
@onready var es_death: ESDeath = %ESDeath


#@onready var sprite_2d: Sprite2D = %Sprite2D


#meta-name :DecisionEngine
#meta - description: Boilerplate decision engine script
#meta - default : true

#included in decisionEngine
#var enemy :Eneme
#Var current_state :EnemyState
#var blackboard : blackboardA

func _ready() -> void:
	

	await super() #maintains important code & timing
	#implement own scripts here
	pass
	
	
func decide() ->EnemyState:
	
	#Example decisions
	if blackboard.damage_source:
		if blackboard.health <=0:
			return es_death
		else:
			return es_stun

	if current_state is ESDeath or not blackboard.can_decide:
		return null
		
	if blackboard.target:
		if blackboard.distance_to_target <40:
			return attack_state
		return chase_state
	
	if blackboard.target:
		if attack_state.can_attack():
			return attack_state
		return chase_state
		
		
	return es_walk  #default state
		
		
