extends CharacterBody2D

@export var SPEED = 100
@export var next_goal_position : Marker2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@export var is_player_near_the_slave : bool = false
var actual_speed = SPEED
var is_angry : bool = false
var angriness : float = 0
var dir : Vector2 
var enable_to_move : bool = true

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var arrow_sprite : Sprite2D = $ArrowSprite

func _ready():
	animation_tree.active = true

func _physics_process(delta): 
	makepath()
	update_angriness(delta)
	
	if nav_agent.is_navigation_finished():
		return #Le joueur ne bouge plus s'il a atteint son goal
	else:
		dir = to_local(nav_agent.get_next_path_position()).normalized() #Donne la direction dans laquelle aller en fonction du chemin trouvé par le node NavigationAgent2D
	if !enable_to_move:
		#Si on est sur un niveau où il faut suivre des formations le maître ne bouge pas 
		actual_speed = 0
	velocity = dir * actual_speed
	arrow_sprite.rotate(arrow_sprite.get_angle_to(next_goal_position.global_position) + PI/2)
	
	move_and_slide()
	animation_tree.set("parameters/Move/blend_position", dir)
	
func update_angriness(delta):
	if is_angry:
		angriness += delta
	else:
		angriness = 0

	angriness = clamp(angriness, 0, 10)
	$Sprite2D.modulate = Color(1, 1 - clamp(angriness/5, 0, 1), 1 - clamp(angriness/5, 0, 1), 1)
	$AngrinessDebugLabel.text = str(angriness)

func makepath():
	if !is_angry:
		nav_agent.target_position = next_goal_position.global_position
		actual_speed = SPEED
	else: 
		nav_agent.target_position = get_node("%Player").get_position()
		actual_speed = SPEED * (1 + angriness / 2)
