class_name HitParticles extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func  start(dir : Vector2, settings: HitParticleSettings) -> void:
	if settings:
		amount = settings.count
		modulate = settings.color
		texture=settings.texture
	process_material.direction = Vector3(dir.x, dir.y, 0)
	emitting=true
	await finished
	queue_free()
	pass # Replace with function body.
