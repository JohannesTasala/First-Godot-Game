extends Node2D


@onready var gunAnim = get_node("GunAnimationPlayer")

func _process(delta):
	look_at(get_global_mouse_position())


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		gunAnim.play("Shoot")
