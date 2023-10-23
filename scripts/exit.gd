extends Area2D

@onready var animation = $AnimatedSprite2D

func _ready():
	pass

func animate():
	animation.play("End")
