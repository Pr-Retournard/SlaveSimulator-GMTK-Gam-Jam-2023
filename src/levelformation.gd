extends Node2D

var is_player_right_place : bool = true
var is_player_near_a_slave : bool = false
var scenario_checklist : Array[bool] 
var number_time : int = 0
var training_number : int = 0
var is_TimerKeepPosition_timeout : bool = false
# Called when the node enters the scene tree for the first time.

func _ready():
	$Master.enable_to_move = false
	$Master/ArrowSprite.visible = false
	positions_init()
	number_time = 0
	training_number = 0
	
func positions_init():
	var Positions = $NextGoalPositions.get_children()
	var pos = 0
	for slave in $Slaves.get_children():
		slave.next_goal_position = Positions[pos]
		pos+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_is_player_near_a_slave()
	update_scenario()
	update_master_behaviour()
	update_win_con()
	is_player_right_place = ($Player.position.distance_to($NextGoalPositions/NextGoalPosition15.position)<64)

func update_win_con():
	if scenario_checklist == [true,true,true]:
		print("You win")

func update_master_behaviour():
	if !is_player_near_a_slave:
		$Master.is_angry = true
	else:
		$Master.is_angry = false

func update_is_player_near_a_slave():
	var next_is_player_near_a_slave : bool = false
	var Slaves = get_node("%Slaves")
	for slave in Slaves.get_children():
		next_is_player_near_a_slave = slave.is_player_near_the_slave or next_is_player_near_a_slave	
	is_player_near_a_slave = next_is_player_near_a_slave
	$Player/DebugLabel.text = str(is_player_right_place)
	
func update_is_player_near_to_the_path():
# a coder
	pass

func move_slaves_of(move_vector : Vector2):
	for mark_goal_position in $NextGoalPositions.get_children():
			mark_goal_position.position += move_vector
			
func move_slaves_in_positions(next_positions: Array[Vector2]):
	var index = 0
	for mark_goal_position in $NextGoalPositions.get_children():
			mark_goal_position.position = next_positions[index]
			index += 1
			
func update_scenario():
	if is_player_right_place:
		match training_number:
			0: # Formation 0 START AVANCER !!! x4
				move_slaves_of(Vector2(111,64))
				number_time += 1
				if number_time == 5:
					training_number += 1
					number_time = 0
			1: # Formation 1 START RECULER !!! x4
				move_slaves_of(-Vector2(111,64))
				number_time += 1
				if number_time == 5:
					training_number += 1
					number_time = 0
			2:
				move_slaves_in_positions(
					#Formation Triangle
					[
						Vector2(-300, -602),
						Vector2(-206, -599),
						Vector2(-122, -592),
						Vector2(-27, -554),
						Vector2(74, -524),
						Vector2(182, -485),
						Vector2(92, -399),
						Vector2(12, -323),
						Vector2(-53, -246),
						Vector2(-123, -199),
						Vector2(-207, -134),
						Vector2(-243, -225),
						Vector2(-260, -318),
						Vector2(-282, -427),
						Vector2(-290, -508)
					]
					# Formation Tortue
#					[
	#					Vector2(-333, -638),#Slave
	#					Vector2(-184, -619),#Slave2
	#					Vector2(-122, -482),#Slave3
	#					Vector2(15, -728),#Slave4
	#					Vector2(43, -479),#Slave5
	#					Vector2(154, -391),#Slave6
	#					Vector2(434, -338),#Slave7
	#					Vector2(145, -242),#Slave8
	#					Vector2(22, -167),#Slave9
	#					Vector2(0, 59),#Slave10
	#					Vector2(-118, -225),#Slave11
	#					Vector2(-422, -270),#Slave12
	#					Vector2(-180, -352),#Slave13
	#					Vector2(-341, -501),#Slave14
	#					Vector2(200,-140)#Player
	#				]
				)
				number_time += 1
				if number_time == 2:
					get_tree().change_scene_to_file("res://src/Win.tscn")

func _on_timer_keep_position_timeout():
	is_TimerKeepPosition_timeout = true
