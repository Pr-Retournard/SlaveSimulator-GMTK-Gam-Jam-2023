extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dir : Vector2

@onready var animation_tree : AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	velocity = dir * SPEED
	move_and_slide()
	
	animation_tree.set("parameters/Move/blend_position", dir)
