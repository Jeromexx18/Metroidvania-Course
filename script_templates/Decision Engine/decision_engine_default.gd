#class_name DecisionEngine
extends DecisionEngine

# meta-name :decisionEngine
#meta-description : BoilerPlate Decision Engine script
#meta-default : true

#includeed in the DecisionEngine:
#var enemy: Enemy
#var current_state: EnemyState
#var blackboard

func _ready() -> void:
	await  super() # maintains important setup code & timing
	#implement your own code
	pass

func decide() ->EnemyState:
	
	
	#if current_state is ESDeath or not blackboard.can_decide:
		#return null
	#Example decisions
	
	return null
