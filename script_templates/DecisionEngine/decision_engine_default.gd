class_name DecisionEngineNameDefault
extends DecisionEngine

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
	#if blackboard.damage_source:
		#if blackboard.health <=0:
			#return es_death
		#else:
			#return es_stun
			#
			
	#if current_state is ESDeath or not blackboard.can_decide:
		#return null
		
	#if blackboard.target:
		#if blackboard.distance_to_target <40:
			#return attact_state?
		#return chase_state?
	return null #default
		
	return null
