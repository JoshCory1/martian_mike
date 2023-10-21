extends StaticBody2D

@onready var strat_position = $SpawnPosition



func get_spawn_pos():
	return strat_position.global_position
