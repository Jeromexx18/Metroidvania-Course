class_name LootData  extends Resource


# Called when the node enters the scene tree for the first time.
@export_file("*.tscn") var item : String
@export var minimum : int = 1
@export var maximum : int= 1
@export var drop_chance : float = 0.25
