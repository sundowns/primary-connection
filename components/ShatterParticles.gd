extends GPUParticles3D

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func fire() -> void:
	emitting = true
	audio.play()
	await finished
	queue_free()
