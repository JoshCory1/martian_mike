extends Area2D

@export var jump_pad_force = 300

@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Player:
		animated_sprite.play("bounceing")
		body.jump(jump_pad_force)