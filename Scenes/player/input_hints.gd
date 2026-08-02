@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_03_game_systems/ch_03_game_systems/icons/input_hints.svg")
class_name InputHints  extends Node2D

var controller_type : String ="keyboard" 
@onready var sprite_2d: Sprite2D = $Sprite2D


const HINT_MAP : Dictionary ={
	"keyboard":{
		"interact": 10,
		"attack": 0,
		"jump": 9,
		"dash": 0,
		"crouch":12 
	},
	
	"xbox":{
		"interact": 1,
		"attack": 2,
		"jump": 0,
		"dash": 0,
		"crouch":0
	},
	
	"playstation":{
		"interact": 4,
		"attack": 7,
		"jump": 0,
		"dash": 0,
		"crouch":0 
	}
	
	#can add more for different controllers XBOX or PS
}


func _ready() -> void:
	visible=false
	Messages.input_hint_changed.connect( _on_hint_changed )
	
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventKey:
		controller_type = "keyboard"
	elif event is InputEventJoypadButton:
		
		get_controller_type(event.device)
	
	
func get_controller_type( device_id )->void:
	
	var n : String = Input.get_joy_name( device_id ). to_lower()
	
	if "xbox" in n :
		controller_type= "xbox"
		
	elif "playstation" in n or "ps" in n or "dualsence" in n:
		controller_type = "playstation"
	#blah blah blah
	else:
		controller_type = "unknown"
	
	print(controller_type)
	set_process_input( false )
	pass
	
	
	
func _on_hint_changed( hint: String ) ->void:
	if hint == "" :
		visible=false
	else:
		visible=true
		sprite_2d.frame = HINT_MAP[ controller_type ].get( hint ,"0"  )
		#update sprite
	pass
