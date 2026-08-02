class_name DecisionEngineBasic
extends DecisionEngine



@onready var es_walk: ESWalk = %ESWalk
@onready var es_stun: Node = %ESStun
@onready var es_death: Node = %ESDeath




func _ready() -> void:
	await  super() # maintains important setup code & timing
	#implement your own code
	pass

func decide() ->EnemyState:
	if blackboard.damage_source:
		if blackboard.health <=0:
			return es_death
		else:
			return es_stun
	if current_state is ESDeath or not blackboard.can_decide:
		return null
		
	if blackboard.edge_detected:
		enemy.change_dir( -blackboard.dir )
		blackboard.edge_detected = false
	#Example decisions
	return es_walk
