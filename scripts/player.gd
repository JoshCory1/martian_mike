extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

var start_pos
var start_vel
var active = true

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	start_pos = self.global_position
	start_vel = self.velocity


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump"): #and is_on_floor():
			jump(jump_force)
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	velocity.x = direction * speed
		
	move_and_slide()
	
	update_animations(direction)
		
func jump(force):
	AudioPlayer.sound_sfx("jump")
	velocity.y = -force

func  update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else :
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

# boolean Operators

# and &&
# or ||
# not !


