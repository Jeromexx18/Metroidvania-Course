@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")


class_name  EnemyState extends Node


@export var animation_name: String

var state_machine:EnemyStateMachine
var enemy : Enemy
var blackboard:Blackboard

func enter() -> void:pass # Replace with function body.
func exit() -> void: pass 
func re_enter() -> void: pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta: float) -> void:pass
