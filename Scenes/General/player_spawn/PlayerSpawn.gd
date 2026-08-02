@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_02_world_building_foundations/ch_02_world_building_foundations/player_spawn.svg")

class_name PlayerSpawn extends Node2D


const PLAYER = preload( "uid://dtskcmvl3b76g" )
	
	#"uid://dtskcmvl3b76g")


func _ready() -> void:
	visible=false
	await get_tree().process_frame
	if get_tree().get_first_node_in_group("Player"):
		print("we have a player")
		
		return
	print("No player found")
	
	
	var player:Player=load("uid://dtskcmvl3b76g").instantiate()
	get_tree().root.add_child((player))
	player.global_position=self.global_position
	#checking to see if we have player 
	#if we have player do nothing
	
	
	#instantiate a new player instance
	
	
	#position the player scene
	
	
	pass
