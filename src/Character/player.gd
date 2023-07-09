extends CharacterBody2D
#Source tilemap https://kenney.nl/assets/isometric-blocks
#https://www.youtube.com/watch?v=SiuVvskVs-0 - How to make isometric pixelart worldmap in Godot - Professor Bubbles Devlog #6
class_name  Player

@export var SPEED = 300.0
var dir : Vector2
var life_counter = 3
var is_hurtable : bool = true

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


func _on_hurt_box_body_entered(body):
	if body is Master and get_node("%Master").angriness > 2 and is_hurtable:
		get_hit()

func get_hit():
	if life_counter > 0:
		is_hurtable = false
		$HurtTimer.start()
		life_counter -= 1
		get_node("%Master").angriness = 0
		
		$UiLifeControl.life = life_counter
		
		print('aie')
		print("PV: ", life_counter)
	else:
		print('already dead')

func _on_hurt_timer_timeout():
	is_hurtable = true
	
