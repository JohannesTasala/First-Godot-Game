extends Node2D


func _ready():
	#Utils.saveGame()
	Utils.loadGame()
	
		

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	#when starting the game check that the player is not already dead from last save
	if Game.playerHP > 0:
		get_tree().change_scene_to_file("res://world.tscn")
	elif Game.playerHP <= 0:
		Game.playerHP = 10
		Game.Gold = 0
		get_tree().change_scene_to_file("res://world.tscn")
