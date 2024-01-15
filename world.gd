extends Node2D

@export var hit_effect: PackedScene

func generate_hit_effect(hit_postition: Vector2)->void:
	var temp = hit_effect.instantiate()
	add_child(temp)
	temp.position = hit_postition


func _on_player_fired_shot(hit_position: Vector2):
	generate_hit_effect(hit_position)
