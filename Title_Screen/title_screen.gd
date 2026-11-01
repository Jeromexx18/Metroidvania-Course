extends CanvasLayer

#region /// ready variables
@onready var main_menu: VBoxContainer = %MainMenu
@onready var new_game_menu: VBoxContainer = %NewGameMenu
@onready var load_game_menu: VBoxContainer = %LoadGameMenu


#buttons
@onready var new_game_button: Button = %NewGameButton
@onready var load_game_button: Button = %LoadGameButton

@onready var new_slot_01: Button = %NewSlot01
@onready var new_slot_02: Button = %NewSlot02
@onready var new_slot_03: Button = %NewSlot03


@onready var load_slot_01: Button = %LoadSlot01
@onready var load_slot_02: Button = %LoadSlot02
@onready var load_slot_03: Button = %LoadSlot03


@onready var animation_player: AnimationPlayer = %AnimationPlayer

#endregion


func _ready() -> void:
	#connect to button signals
	#add audio here to buttons
	#show main menu
	#setup logo transition
	new_game_button.pressed.connect( show_new_game_menu )
	load_game_button.pressed.connect( show_load_game_menu )
	
	new_slot_01.pressed.connect( _on_new_game_pressed.bind( 0 ) )
	new_slot_02.pressed.connect( _on_new_game_pressed.bind( 1 ) )
	new_slot_03.pressed.connect( _on_new_game_pressed.bind( 2 ) )
	
	load_slot_01.pressed.connect( _on_load_game_finished.bind(0))
	load_slot_02.pressed.connect( _on_load_game_finished.bind(1))
	load_slot_03.pressed.connect( _on_load_game_finished.bind(2))
	
	Audio.setup_button_audio( self )
	
	
	show_main_menu()
	animation_player.animation_finished.connect(_on_animation_finished)
	pass

func  show_new_game_menu():
	
	main_menu.visible = false
	new_game_menu.visible =true
	load_game_menu.visible = false
	
	if SaveManager.save_file_exists( 0 ):
		new_slot_01.text = "NEW GAME SLOT 01 "
		new_slot_01.grab_focus()
	
	if SaveManager.save_file_exists( 1 ):
		new_slot_02.text = "NEW GAME SLOT 02"
		new_slot_02.grab_focus()
	if SaveManager.save_file_exists( 2 ):
		new_slot_03.text = "NEW GAME SLOT 03"
		new_slot_03.grab_focus()

		
	
	pass


func show_load_game_menu() ->void:
	main_menu.visible = false
	new_game_menu.visible =false
	load_game_menu.visible = true
	
	load_slot_01.disabled = not SaveManager.save_file_exists(0)
	load_slot_02.disabled = not SaveManager.save_file_exists(1)
	load_slot_03.disabled = not SaveManager.save_file_exists(2)
	load_slot_01.grab_focus()
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed( "UI cancel"):
		if main_menu.visible == false:
			#play audio here
			show_main_menu()
	pass

func show_main_menu()->void:
	main_menu.visible = true
	new_game_menu.visible =false
	load_game_menu.visible = false
	new_game_button.grab_focus()
	
	pass
	
func _on_new_game_pressed( slot:int )->void:
	
	SaveManager.create_new_game_save( slot )
	#SceneManager.transition_scene( 
		#"uid://4de5u0v72m5y",
		#"", Vector2.ZERO, "up"  )
	
	pass
	
	
func _on_load_game_finished( slot:int ) ->void:
	SaveManager.load_game( slot )
	pass
	
func _on_animation_finished( anim_name : String)->void:
	if anim_name == "start":
		animation_player.play( "loop" )
	pass
