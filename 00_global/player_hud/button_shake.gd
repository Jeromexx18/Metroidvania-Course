extends Button




func _ready()->void:
	pressed.connect( _on_pressed )
	pass
	
	
func _on_pressed() -> void:
	
	VisualEffects.camera_shake()
	pass
