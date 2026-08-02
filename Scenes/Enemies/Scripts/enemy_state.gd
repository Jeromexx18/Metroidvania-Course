@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_01_player_foundations/ch_01_player_foundations/state.svg")

class_name EnemyState  extends Node


@export var animation_name:String

var state_machine: EnemyStateMachine
var enemy : Enemy
var blackboard : Blackboard

# Called when the node enters the scene tree for the first time.
func enter() -> void: pass # Replace with function body.
func re_enter() -> void:pass

func exit() -> void: pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta: float) -> void: pass
