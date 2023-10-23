extends Node2D

var player_position


func _process(delta):
	if Input.is_action_just_pressed("quit") and Global.last_scene != null:
		get_tree().change_scene_to_file(Global.last_scene)
	

func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
