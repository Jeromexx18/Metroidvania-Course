class_name PauseMenu extends CanvasLayer

#region /// variables
@onready var pause_screen: Control = %PauseScreen
@onready var system_menu_button: Button = %SystemMenuButton


@onready var system: Control = %System




@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISlider



@onready var back_to_map_button: Button = %BackToMapButton
@onready var back_to_title_button: Button = %BackToTitleButton

var player_position :Vector2

#endregion

#var player : Player

func _ready() -> void:
	#grab player
	#show map
	#audio setup
	#setup system
	process_mode=Node.PROCESS_MODE_ALWAYS
	show_pause_menu()
	system_menu_button.pressed.connect( show_system_menu )
	Audio.setup_button_audio( self )
	setup_system_menu()
	var player : Node2D = get_tree().get_first_node_in_group( "Player" )
	if player:
		player_position = player.global_position
	
	pass
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed( "pause" ):
		print("paused")
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		queue_free()
		return
	if event.is_action_pressed("action"):
		get_viewport().set_input_as_handled()
		var focused =get_viewport().gui_get_focus_owner()
		if focused is Button:focused.emit_signal("pressed")
	if pause_screen.visible== true:
		if event.is_action_pressed("right") or event.is_action_pressed("down"):
			system_menu_button.grab_focus()
		
	pass

func show_pause_menu():
	pause_screen.visible = true
	system.visible = false
	back_to_map_button.grab_focus()
	pass
	
	
func show_system_menu() ->void:
	
	pause_screen.visible = false
	system.visible = true
	back_to_map_button.grab_focus() 
	pass

func setup_system_menu():
	music_slider.value = AudioServer.get_bus_volume_linear( 2 )
	sfx_slider.value = AudioServer.get_bus_volume_linear( 3 )
	ui_slider.value = AudioServer.get_bus_volume_linear( 4 )
	
	music_slider.value_changed.connect( _on_music_slider_changed )
	sfx_slider.value_changed.connect(_on_sfx_slider_changed )
	ui_slider.value_changed.connect( _on_ui_slider_changed )
	
	back_to_title_button.pressed.connect( _on_back_to_title_pressed  )
	back_to_map_button.pressed.connect( show_pause_menu )
	
	pass
	
func show_pause_screen()->void :
	pause_screen.visible = true
	system.visible = false
	pass

func _on_back_to_title_pressed() ->void:
	#get rid of the player
	SceneManager.transition_scene("res://Platformer/Title_Screen/title_screen.tscn" , "", Vector2.ZERO, "up" )
	get_tree().paused = true
	Messages.back_to_title_screen.emit()
	queue_free()
	
	pass
	#v for bus volume
func _on_music_slider_changed( v :float ) ->void:
	AudioServer.set_bus_volume_linear( 2, v )
	SaveManager.save_configuration()
	#save to settings
	
	pass
	
func _on_sfx_slider_changed( v :float ) ->void:
	AudioServer.set_bus_volume_linear( 3, v )
	Audio.play_spatial_sound( Audio.ui_focus_audio, player_position )
	SaveManager.save_configuration()
	#save to settings
	
	pass
	
	
func _on_ui_slider_changed( v :float ) ->void:
	AudioServer.set_bus_volume_linear( 4, v )
	Audio.ui_focus_change()
	SaveManager.save_configuration()
	#save to settings
	
	pass
	
	
