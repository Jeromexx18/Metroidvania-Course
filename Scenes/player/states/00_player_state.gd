@icon ("res://METROIDVAINIA/ch_01_player_foundations/ch_01_player_foundations/state.svg")

class_name PlayerState extends Node

var player:Player
var next_state:PlayerState


#region /// this has atleast 6 states it will handle iow state references
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var fall: PlayerStateFall = %Fall
@onready var crouch:PlayerStateCrouch=%Crouch
@onready var jump: PlayerStateJump = %Jump
@onready var attack: PlayerAttack = %Attack

@onready var take_damage: PlayerStateTakeDamage = %TakeDamage
@onready var death: PlayerStateDeath = %Death
@onready var dash: PlayerStateDash = %Dash
@onready var ground_slam: Node = %GroundSlam
@onready var ball: Node = %Ball


#endregion


func init()->void:
	
	pass
	
	
func enter()->void:
	pass

func exit()->void:
	pass
	
	
	#
func handle_input(_event: InputEvent) -> PlayerState:
	
	return next_state
	
	
func process(_delta: float) -> PlayerState:
	return next_state
	

func physics_process(_delta: float)->PlayerState:
	return next_state
	
