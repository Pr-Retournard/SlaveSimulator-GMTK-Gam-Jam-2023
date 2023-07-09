extends Node2D

@export var active : bool = true
@export var dir : Vector2
@onready var animation_tree: AnimationTree = $PinkmanAnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if active != animation_tree.active:
		animation_tree.active = active
	
	animation_tree.set("parameters/Move/blend_position", dir)
