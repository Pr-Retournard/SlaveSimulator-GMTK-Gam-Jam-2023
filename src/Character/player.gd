extends CharacterBody2D
#Source tilemap https://kenney.nl/assets/isometric-blocks
#https://www.youtube.com/watch?v=SiuVvskVs-0 - How to make isometric pixelart worldmap in Godot - Professor Bubbles Devlog #6
class_name  Player

@export var SPEED = 300.0
var dir : Vector2

@onready var pinkmanAnimationHandler = $PinkmanAnimationHandler

func _ready():
	pinkmanAnimationHandler.active = true

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = dir * SPEED
	move_and_slide()
	pinkmanAnimationHandler.dir = dir

func _unhandled_input(_event : InputEvent):
	dir.x = Input.get_axis("ui_left","ui_right")
	dir.y = Input.get_axis("ui_up","ui_down")
	dir = dir.normalized()
