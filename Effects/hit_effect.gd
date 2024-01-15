extends Node2D

@onready var particle = $GPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready():
	particle.emitting = true


func _on_timer_timeout():
	queue_free()
