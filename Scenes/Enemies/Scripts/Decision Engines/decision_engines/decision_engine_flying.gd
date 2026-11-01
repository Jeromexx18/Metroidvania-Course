class_name DecisionEngineFlying
extends DecisionEngine


@export var fly_state: EnemyState
@export var chase_state: EnemyState
@export var stun_state: EnemyState
@export var attack_state: EnemyState
@export var death_state: EnemyState

@onready var sprite_2d: Sprite2D = %Sprite2D
#@onready var es_fly_attack: ESFlyAttack = %ESFlyAttack

#meta-name :DecisionEngine
#meta - description: Boilerplate decision engine script
#meta - default : true

#included in decisionEngine
#var enemy :Eneme
#Var current_state :EnemyState
#var blackboard : blackboard

func _ready() -> void:
	await super() #maintains important code & timing
	#implement own scripts here
	
	pass
	
	
func decide() ->EnemyState:
	
	#Example decisions
	if blackboard.damage_source:
		if blackboard.health <=0:
			return death_state
		else:
			return stun_state
			
	if current_state is ESDeath or not blackboard.can_decide:
		return null
		
	if blackboard.target:
		if attack_state.can_attack():
			return attack_state
		return chase_state
	return fly_state
	




		
