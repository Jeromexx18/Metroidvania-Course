extends Label

@onready var player_sensor: PlayerSensor = $"../PlayerSensor"





@onready var living_armor: Enemy = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	text = ""
	text ="target = " 
	text += str(living_armor.blackboard.target.name) if living_armor.blackboard.target else ""
	text += "\n dist ="
	text += str(living_armor.blackboard.distance_to_target)
	pass
