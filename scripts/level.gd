extends Node2D

@export var next_level: PackedScene = null
@export var levl_time = 30
@export var is_final_level: bool = false

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $DeathZone
@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer

var time_left
var player = null
var timer_node = null
var win = false

func _ready():
	Global.last_scene = get_tree().current_scene.scene_file_path
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		if Global.player_pos != null:
			player.global_position = Global.player_pos
		else:
			player.global_position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	
	for n in traps:
		#n.connect("touched_player", _on_trap_touched_player)
		n.touched_player.connect(_on_trap_touched_player)
	exit.body_entered.connect(_on_exit_body_enterd)
	death_zone.body_entered.connect(_on_deathzone_body_enterd)
	
	if Global.time != null:
		time_left = Global.time
	else:
		time_left = levl_time
	hud.set_time_lable(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()


func _process(delta):
	if win == false:
		Global.time = time_left
		Global.player_pos = player.global_position
	else:
		Global.time = null
		Global.player_pos = null
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_enterd(body):
	AudioPlayer.sound_sfx("hurt")
	reset_player()

func _on_trap_touched_player():
	AudioPlayer.sound_sfx("hurt")
	reset_player()

func reset_player():
	time_left = levl_time
	hud.set_time_lable(time_left)
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_pos()


func _on_exit_body_enterd(body):
	if body is Player:
		if is_final_level || next_level != null:
			exit.animate()
			player.active = false
			win = true
			await get_tree().create_timer(1.5).timeout
			if is_final_level:
				ui_layer.show_win_sceen(true)
			else :
				get_tree().change_scene_to_packed(next_level)
			
func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_lable(time_left)
		if time_left < 0:
			AudioPlayer.sound_sfx("hurt")
			reset_player()
			time_left = levl_time
			hud.set_time_lable(time_left)
