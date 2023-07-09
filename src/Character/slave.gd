extends CharacterBody2D

class_name Slave
#https://www.youtube.com/watch?v=Lt9YdQ6Ztm4 - How To Create PATHFINDING in Godot 4
@export var SPEED = 200.0
var dir : Vector2
@export var next_goal_position : Marker2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var is_player_near_the_slave : bool = false
@onready var pinkmanAnimationHandler = $PinkmanAnimationHandler

func _ready():
	pinkmanAnimationHandler.active = true
	makepath()
	
func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		animate()
		return #Le joueur ne bouge plus s'il a atteint son goal
	else:
		dir = to_local(nav_agent.get_next_path_position()).normalized() #Donne la direction dans laquelle aller en fonction du chemin trouvé par le node NavigationAgent2D
		velocity = dir * SPEED
	move_and_slide()
	animate()
	
func makepath():
	nav_agent.target_position = next_goal_position.global_position

func _on_timer_timeout():
	makepath()

func _on_area_2d_body_entered(body):
	if body is Player:
		is_player_near_the_slave = true

func _on_area_2d_body_exited(body):
	if body is Player:
		is_player_near_the_slave = false

func animate():
	pinkmanAnimationHandler.dir = velocity
	
