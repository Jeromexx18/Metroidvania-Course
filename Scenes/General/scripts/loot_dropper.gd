@icon("res://METROIDVAINIA GAMERESOURCE/Metroidvania_Assets/ch_05_enemies/ch_05_enemies/icons/loot_drop.svg")

class_name LootDropper extends Marker2D


@export var items: Array [LootData]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if owner is Enemy:
		owner.was_killed.connect( drop_loot )
	elif owner is Breakable:
		owner.destroyed.connect( drop_loot  )
	
		pass # Replace with function body.


func drop_loot():
	for i in items: 
		if i.drop_chance <= randf():
			continue
			
		var drop_scene = load(i.item)
		var count: int = randi_range(i.minimum, i.maximum)
		for j in count:
			
			var drop : CharacterBody2D = drop_scene.instantiate()
			owner.add_sibling.call_deferred( drop )
			drop.global_position = global_position 
			if drop is CharacterBody2D:
				drop.velocity = Vector2( randf_range(-50,50), randf_range(-200, -400) )
		
		
		
	pass
