extends CharacterBody2D

@export var SPEED = 200.0
@export var next_goal_position : Marker2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	makepath()
	
func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return #Le joueur de bouge plus s'il a atteint son goal
	else:
		var dir = to_local(nav_agent.get_next_path_position()).normalized() #Donne la direction dans laquelle aller en fonction du chemin trouvé par le node NavigationAgent2D
		velocity = dir * SPEED
	move_and_slide()
	
func makepath():
	nav_agent.target_position = next_goal_position.global_position

func _on_timer_timeout():
	makepath()
