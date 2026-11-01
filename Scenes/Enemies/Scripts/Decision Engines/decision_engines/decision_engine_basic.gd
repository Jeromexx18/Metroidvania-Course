#classs_name DecisionEngineBasic
extends DecisionEngine

#meta-name :DecisionEngine
#meta - description: Boilerplate decision engine script
#meta - default : true

#included in decisionEngine
#var enemy :Eneme
#Var current_state :EnemyState
#var blackboard : blackboard

@onready var es_walk: ESWalk = %ESWalk
@onready var es_stun: ESStun = %ESStun
@onready var es_death: ESDeath = %ESDeath



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
		
	if blackboard.edge_detected:
		enemy.change_dir(-blackboard.dir)
		
	return es_walk #default
		
